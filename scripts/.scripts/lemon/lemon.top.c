/***************************************************\
* Author:   Jonesad@etsu.edu			    *
* Date l.m: 1/16/21				    *
* Purpose:  Pipes output of scripts into lemonbar.  *   		
\****************************************************/

#define DEBUG	      1
#define HOME          "/home/jonesad"
#define LEMON         HOME"/.scripts/lemon"
#define FIFO          HOME"/.lemonbar_top.fifo"
#define SIDE_BUFFER   10
#define NUM_MODS      9
#define BUFFER_SIZE   450
#define DELIM         " | "
#define LEFT_DELIM    DELIM
#define LEFT          -1
#define CENTER_DELIM  DELIM  
#define CENTER        0
#define RIGHT_DELIM   " || "
#define RIGHT         1
#define SIGS_START    40

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
  int align;
  int order;
  char pre[BUFFER_SIZE];
  char post[BUFFER_SIZE];
  int timer;
  int signal;
} module;

void  reader      (   );
void  handler     (   );
void  catcher     ( int );
void  send        ( char*, int, int, int );
void  setup       ( module );
void  exec        ( module, char*, int );
void  format      ( char*, char*, char*, char* );
int   capture     ( char*, char* );

int catchfd[2];
int LEFT_COUNTER = 0,
    CENTER_COUNTER = 0,
    RIGHT_COUNTER = 0,
    MAIN_PID = -1;

//Need to remove dependence on NUM_MODS.
struct module modules[NUM_MODS] = {
  /*  COMMAND                       ALIGN    ORDER  PRE     POST    TIMER	SIGNAL   */
    { LEMON"/lemon-power.sh",      RIGHT,   5,     "",     "",     -1,	1  },
    { LEMON"/lemon-battery.sh",     CENTER,  1,     "",     "",     30,	2    },
    { LEMON"/lemon-time.sh",        RIGHT,   4,     "",     "",     30,	3    },
    { LEMON"/lemon-brightness.sh",  RIGHT,   3,     "",     "",     10,	4    },
//    { LEMON"/lemon-cpu.sh",         RIGHT,   3,     "",     "",     3, 5   },
//    { LEMON"/lemon-mem.sh",         RIGHT,   2,     "",     "",     4,	6     },
    { LEMON"/lemon-ewmh.sh",        LEFT,    2,     "",     "",     -1,	7    },
    { LEMON"/lemon-launcher.sh",	    LEFT,    1,	    "",	    "",	    -1,	8    },
    { LEMON"/lemon-mpd.sh",	LEFT,		3,	"",	"",	-1,	9	},
    { LEMON"/lemon-connected.sh",	RIGHT,	2,	"",	"",	-1,	10 },
    { LEMON"/lemon-kernel.sh",	RIGHT,		1,	"",	"",	-1,	11 },
};

int
main ( int argc, char** argv ) {

  /* Makes named pipe  */
  if ( access ( FIFO, F_OK  ) == 0 )
    remove ( FIFO );
  mkfifo ( FIFO, 0666 );

  /* Makes pipe for handling caught signals without
   * violating POSIX standards */
  pipe ( catchfd );

  /* Makes Children ignore signals*/
  struct sigaction ign;
  ign.sa_handler = SIG_IGN;
  sigemptyset ( &ign.sa_mask );
  for ( int i = 0; i < NUM_MODS; i++)
    sigaction ( SIGS_START + modules [i].signal, &ign, NULL ); 
  
  /* Instantiates each module  */
  int alignment = -2;
  module* end = modules + sizeof ( modules ) / sizeof( modules [0] );
  for ( module* ptr = modules; ptr < end; ptr++ ) {
   
    setup ( *ptr );

    alignment = ptr->align; 
    ( alignment == CENTER ) ? CENTER_COUNTER++ :
      ( alignment == LEFT ) ? LEFT_COUNTER++ : RIGHT_COUNTER ++ ;
  }

  /* Makes passing 40 + m.signal in modules array through kill update the module */
  MAIN_PID = getpid();
  struct sigaction act;
  act.sa_handler = catcher;
  sigemptyset ( &act.sa_mask );
  act.sa_flags = SA_RESTART;
  for ( int i = 0; i < NUM_MODS; i++) {
	sigaction ( SIGS_START + modules[i].signal, &act, NULL ); 
  }
  int dummypid = fork ( );
  if ( dummypid == 0 )
    handler ( );
  else if ( dummypid > 0 )
     reader ( ); 
}

void
handler (  ) {
  module m;
  char tmp [BUFFER_SIZE];
  int fd = open ( FIFO, O_WRONLY );
  while ( read ( catchfd [0], &m, sizeof(module) ) > 0 )
    exec ( m, tmp, fd); 
    sleep (1);
}

void
catcher ( int signum ) {
  if ( getpid() != MAIN_PID )
    return;
  if ( !DEBUG ) printf( "\n* SIGNAL RECEIVED: *%d\n", signum ); fflush (stdout);
  
  module *last = modules + sizeof(modules)/sizeof(modules[0]);
  for ( module *ptr = modules; ptr < last; ptr++ ) {
  	if ( SIGS_START + ptr->signal == signum ) {
  		write ( catchfd [1], ptr, sizeof (module) );
		break;
	}
  }
}

void
reader (  ) {

  message *msg      = malloc ( sizeof (message) );
  int 	  strsize   = ( BUFFER_SIZE * (CENTER_COUNTER+LEFT_COUNTER+RIGHT_COUNTER) );
  int     used;
  char    *str      = malloc ( strsize );
  char    *center [CENTER_COUNTER],  
          *left   [LEFT_COUNTER],
          *right  [RIGHT_COUNTER];

  for ( int i = 0; i < CENTER_COUNTER; i++ )
    center [ i ] = malloc ( BUFFER_SIZE );
  for ( int i = 0; i < LEFT_COUNTER; i++ )
    left [ i ] = malloc ( BUFFER_SIZE );
  for ( int i = 0; i < RIGHT_COUNTER; i++ )
    right [ i ] = malloc ( BUFFER_SIZE );

  int bytesread = -1 ,
      fd  = open ( FIFO, O_RDONLY );
  
  while ( ( bytesread = read (fd, msg, sizeof (message))) > 0) {
    /* Parse Alignment and Order */
    if ( msg->align == LEFT ) 
    strncpy ( left [ msg->order ], msg->text, BUFFER_SIZE );  
    else if ( msg->align == CENTER ) 
      strncpy ( center [ msg->order ], msg->text, BUFFER_SIZE );
    else if (msg->align == RIGHT ) 
      strncpy ( right [ msg->order ], msg->text, BUFFER_SIZE ); 
    
    if ( !DEBUG ) { //IF DEBUGGING 
    for ( int i = 0; i < LEFT_COUNTER; i++ ) {
    	printf ( "LEFT[%d]:\t%s\n",i, left [i]); 
    }

    for ( int i = 0; i < CENTER_COUNTER; i++ ) {
    	printf ( "CENTER[%d]:\t%s\n",i, center [i]); 
    }

    for ( int i = 0; i < RIGHT_COUNTER; i++ ) {
    	printf ( "RIGHT[%d]:\t%s\n",i, right [i]); 
    }
    fflush ( stdout );
    }
    else {
	used = 0;
	used += snprintf ( str+used, strsize-used, "%%{l}%%{O%d}", SIDE_BUFFER );
	for ( int i = 0; i < LEFT_COUNTER-1; i++ ) 
	  used += snprintf ( str+used, strsize-used, "%s"LEFT_DELIM, left [i] ); 
	used += snprintf ( str+used, strsize-used, "%s%%{c}", left [LEFT_COUNTER-1] ); 

	for ( int i = 0; i < CENTER_COUNTER-1; i++ )
	  used += snprintf ( str+used, strsize-used, "%s"CENTER_DELIM, center [i] ); 
	used += snprintf ( str+used, strsize-used, "%s%%{r}", center [CENTER_COUNTER-1] ); 

	for ( int i = 0; i < RIGHT_COUNTER-1; i++ )
	  used += snprintf ( str+used, strsize-used, "%s"RIGHT_DELIM, right [i] ); 
	used += snprintf ( str+used, strsize-used, "%s%%{O%d}\n", right [RIGHT_COUNTER-1], SIDE_BUFFER ); 

	printf ( str );
	fflush ( stdout ); 
  }
  }
}


void
send ( char* msg, int order, int align, int out ) {
  message receipt = { "", order-1, align };
  strcpy  ( receipt.text, msg);  
  write   ( out, &receipt, sizeof ( message ) );
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
      while ( 1 ) {
        exec  ( m, tmp, fd ); 
        if ( m.timer == -1 ) { exit ( 0 ); }
        sleep ( m.timer );
      } 
  } else {
     
  }
}

void
exec ( module m, char* tmp, int fd ) {
  capture ( m.cmd, tmp );
  format  ( tmp, m.pre, m.post, tmp ); 
  //printf ("FORMAT:%s\n",tmp); fflush ( stdout ); 
  send    ( tmp, m.order, m.align, fd);    
}

/* FROM ROSETTACODE- doesn't work well*/
int
capture(char* cmd, char* cmdout) {
 FILE *fd;
 fd = popen(cmd, "re");
 if (!fd) return -1;

 char   buffer [ 256 ];
 size_t chread;

 /* String to store entire command contents in */
 size_t comalloc = 256;
 size_t comlen   = 0;
 char  *comout   = (char*) calloc ( comalloc, sizeof (char) );
 
 /* Use fread so binary data is dealt with correctly */
 while ((chread = fread ( buffer, 1, sizeof ( buffer ), fd) ) != 0) {
   if (comlen + chread >= comalloc) {
    comalloc *= 2;
    comout = realloc ( comout, comalloc );
   }
   memmove ( comout + comlen, buffer, chread );
   comlen += chread;
  }

 fflush ( fd );
 strcpy ( cmdout, comout );
 cmdout [ strlen ( cmdout ) ] = 0x00;
 free   ( comout );
 pclose ( fd );
}
  
void
format(char* script, char* pre, char* post, char* out) {
  char tmp [ BUFFER_SIZE ];
  strcpy ( tmp, pre );
  strcat ( tmp, script );
  strcat ( tmp, post );
  strcpy ( out, tmp );
}
