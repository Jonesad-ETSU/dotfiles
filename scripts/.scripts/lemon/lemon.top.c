/************************************
Author:   Jonesad@etsu.edu
Date l.m: 1/2/21
Purpose:  Runs scripts asynchronously, printing output to a pipe and piping into lemonbar.
*************************************/

#define HOME        "/home/jonesad"
#define LEMON       HOME"/.scripts/lemon"
#define FIFO        HOME"/.lemonbar_top.fifo"
#define NUM_MODS    7 
#define BUFFER_SIZE 450
#define DELIM       "  "
#define LEFT        -1
#define CENTER      0
#define RIGHT       1

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <unistd.h>

typedef struct message {
  char text[BUFFER_SIZE];
  int order, align;
} message;

typedef struct module {
  char cmd[BUFFER_SIZE];
  char align, order;
  char pre[BUFFER_SIZE];
  char post[BUFFER_SIZE];
  int timer;
} module;

void  reader      (   );
void  send        ( char*, int, int, int );
void  setup       ( module );
void  exec        ( module, char*, int );
void  format      ( char*, char*, char*, char* );
int   capture     ( char*, char* );

int LEFT_COUNTER = 0,
    CENTER_COUNTER = 0,
    RIGHT_COUNTER = 0;

//Need to remove dependence on NUM_MODS.
struct module modules[NUM_MODS] = {
  /*  COMMAND                       ALIGN    ORDER  PRE     POST    TIMER   */
  //{ "echo -n Hello, World!",      RIGHT,   6,     "%{A:firefox:}",     "%{A}",     460    },
    { LEMON"/lemon-battery.sh",     CENTER,  1,     "",     "",     60    },
    { LEMON"/lemon-time.sh",        RIGHT,   5,     "",     "",     30    },
    { LEMON"/lemon-id.sh",          RIGHT,   4,     "",     "",     360   },
    { LEMON"/lemon-brightness.sh",  RIGHT,   3,     "",     "",     30    },
    { LEMON"/lemon-home.sh",        RIGHT,   2,     "",     "",     120   },
    { LEMON"/lemon-mem.sh",         RIGHT,   1,     "",     "",     2     },
    { LEMON"/lemon-ewmh.sh",        LEFT,    1,     "",     "",     0     },
};

int
main() {

  /* Makes named pipe  */
  if ( access ( FIFO, F_OK  ) == 0 )
    remove ( FIFO );
  mkfifo ( FIFO, 0666 );

  /* Instantiates each module  */
  int alignment = -2;
  module* end = modules + sizeof ( modules ) / sizeof( modules [0] );
  for ( module* ptr = modules; ptr < end; ptr++ ) {
   
    setup ( *ptr );

    alignment = ptr->align; 
    ( alignment == CENTER ) ? CENTER_COUNTER++ :
      ( alignment == LEFT ) ? LEFT_COUNTER++ : RIGHT_COUNTER ++ ;
  }
  /* Reads order pipe and prints to screen  */
  reader();
}

void
reader() {
  message *msg        = malloc ( sizeof(message) );
  char    *centerstr  = malloc ( sizeof(BUFFER_SIZE)*CENTER_COUNTER),
          *leftstr    = malloc ( sizeof(BUFFER_SIZE)*LEFT_COUNTER),
          *rightstr   = malloc ( sizeof(BUFFER_SIZE)*RIGHT_COUNTER);

  char  *center [CENTER_COUNTER],  
        *left   [BUFFER_SIZE],
        *right  [RIGHT_COUNTER];

  for ( int i = 0; i < CENTER_COUNTER; i++)
    center[i] = malloc(BUFFER_SIZE*10);
  for ( int i = 0; i < LEFT_COUNTER; i++)
    left[i] = malloc(BUFFER_SIZE*10);
  for ( int i = 0; i < RIGHT_COUNTER; i++)
    right[i] = malloc(BUFFER_SIZE*10);

  int bytesread = -1 ,
      fd  = open ( FIFO, O_RDONLY );
  
  while ( ( bytesread = read (fd, msg, sizeof (message))) > 0) {
    /* Parse Alignment and Order */
    if ( msg->align == LEFT ) {
      strcpy ( left [ msg->order ], msg->text );  
    } else if ( msg->align == CENTER ) {
      strcpy ( center [ msg->order ], msg->text );
    } else if (msg->align == RIGHT ) {
      strcpy ( right [ msg->order ], msg->text ); 
    }
    
    /* Iterates through and prints bar (Building string may be faster- future testing needed)  */
    printf ( "\%{l}" );
    for ( int i = 0; i < LEFT_COUNTER - 1; i++ ) 
      printf ( "%s" DELIM, left [ i ] );
    printf ( "%s" DELIM, left [ LEFT_COUNTER - 1 ] );
    
    printf ( "\%{c}" );
    for ( int i = 0; i < CENTER_COUNTER - 1; i++ )
      printf ( "%s" DELIM, center [ i ] );
    printf( "%s", center [ CENTER_COUNTER - 1] );
    
    printf ( "\%{r}" );
    for ( int i = 0; i < RIGHT_COUNTER - 1; i++ ) 
      printf ( "%s" DELIM, right [ i ] );
    printf ( "%s", right [ RIGHT_COUNTER - 1 ] );
    printf ( "\n" );

    fflush ( stdout );
  }
}


void
send ( char* msg, int order, int align, int out ) {
  message* receipt  = malloc(sizeof(message));
  receipt->order    = order-1;
  receipt->align    = align;
  strcpy  ( receipt->text, msg );

  write   ( out, receipt, sizeof(message));
  free    ( receipt);
}

void
setup ( module m ) {

  char tmp[BUFFER_SIZE];
  
  /* forks off and updates */
  int dummypid = fork(); 
  if ( dummypid < 0 ) {
    printf  ( "Fork of >> %s << failed\n", m.cmd ); 
    fflush  ( stdout );
  }
  else if ( dummypid == 0 ) {
    int fd = open ( FIFO, O_WRONLY );
    do {
      exec  ( m, tmp, fd ); 
      if (m.timer == -1) { break; }  //DOES NOT WORK YET
      sleep   ( m.timer );
    } while (1);
  } else {
     
  }
}

void
exec ( module m, char* tmp, int fd) {
  capture ( m.cmd, tmp );
  format  ( tmp, m.pre, m.post, tmp );
  send    ( tmp, m.order, m.align, fd);    
}

int
capture(char* cmd, char* cmdout) {
 FILE *fd;
 fd = popen(cmd, "r");
 if (!fd) return -1;

 char   buffer[256];
 size_t chread;

 /* String to store entire command contents in */
 size_t comalloc = 256;
 size_t comlen   = 0;
 char  *comout   = malloc(comalloc);
 
 /* Use fread so binary data is dealt with correctly */
 while ((chread = fread(buffer, 1, sizeof(buffer), fd)) != 0) {
   if (comlen + chread >= comalloc) {
    comalloc *= 2;
    comout = realloc(comout, comalloc);
   }
   memmove (comout + comlen, buffer, chread);
   comlen += chread;
  }

 strcpy (cmdout, comout);
 cmdout [ strlen ( cmdout ) ] = 0x00;
 free   (comout);
 pclose (fd);
}
  
void
format(char* script, char* pre, char* post, char* out) {
  char tmp [ BUFFER_SIZE ];
  strcpy ( tmp, pre );
  strcat ( tmp, script );
  strcat ( tmp, post );
  strcpy ( out, tmp );
}