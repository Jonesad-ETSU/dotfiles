/***************************************************\
* Author:   Jonesad@etsu.edu			    *
* Date l.m: 1/16/21				    *
* Purpose:  Pipes output of scripts into lemonbar.  *   		
\****************************************************/

#define HOME          "/home/jonesad"
#define LEMON         HOME"/.scripts/lemon"
#define FIFO          HOME"/.lemonbar_top.fifo"
#define SIDE_BUFFER   10
#define NUM_MODS      9
#define BUFFER_SIZE   300
#define DELIM         " | "
#define LEFT_DELIM    DELIM
#define LEFT          -1
#define CENTER_DELIM  DELIM  
#define CENTER        0
#define RIGHT_DELIM   DELIM
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
int   ascii	  ( char* );

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
  module* m = malloc ( sizeof ( module ) );
  int bytesread = -1;
  char tmp [BUFFER_SIZE];
  int fd = open ( FIFO, O_WRONLY );
  while ( ( bytesread = read (catchfd [0], m, sizeof(module) ) ) > 0 ) {
    exec ( *m, tmp, fd); 
  }
}

void
catcher ( int signum ) {
  if ( getpid() != MAIN_PID )
    return;
  
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

  message *msg  = malloc ( sizeof (message) );
  char  *center [CENTER_COUNTER],  
        *left   [BUFFER_SIZE],
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
    
    //Printing Solution, definitely mostly works
    printf ( "\%{l}\%{O%d}", SIDE_BUFFER );
    for ( int i = 0; i < LEFT_COUNTER-1; i++ ) {
    	printf ( "%s"LEFT_DELIM, left [i]); 
    }
    printf ("%s",left [LEFT_COUNTER-1] );
    
    printf ( "\%{c}" ); 
    for ( int i = 0; i < CENTER_COUNTER-1; i++ ) {
    	printf ( "%s"CENTER_DELIM, center [i] ); 
    }
    printf ( "%s",center [CENTER_COUNTER-1] );

    printf ( "\%{r}" );
    for ( int i = 0; i < RIGHT_COUNTER-1; i++ ) {
    	printf ( "%s"RIGHT_DELIM, right [i] );
    }
    printf ( "%s", right [RIGHT_COUNTER-1] );
    printf ( "\%{O%d}", SIDE_BUFFER );
    fflush ( stdout );
  }
}


void
send ( char* msg, int order, int align, int out ) {
  message* receipt  = malloc ( sizeof ( message ) );
  receipt->order    = order-1;	//Remove -1 if you wish to start with order 0.
  receipt->align    = align;
  strcpy  ( receipt->text, msg ); 
  //printf("Receipt->text: %sReceipt->order: %d Receipt->align: %d",receipt->text, receipt->order-1, receipt->align);fflush(stdout);

  write   ( out, receipt, sizeof ( message ) );
  free    ( receipt );
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
  //printf("Capture Returned: %s",tmp);fflush(stdout);
  format  ( tmp, m.pre, m.post, tmp );
  //printf("Format returned: %s",tmp);fflush(stdout);
  send    ( tmp, m.order, m.align, fd);    
}

int
capture(char* cmd, char* cmdout) {
 FILE *fd;
 fd = popen(cmd, "r");
 if (!fd) return -1;

 char   buffer [ 256 ];
 size_t chread;

 /* String to store entire command contents in */
 size_t comalloc = 256;
 size_t comlen   = 0;
 char  *comout   = malloc ( comalloc );
 
 /* Use fread so binary data is dealt with correctly */
 while ((chread = fread ( buffer, 1, sizeof ( buffer ), fd) ) != 0) {
   if (comlen + chread >= comalloc) {
    comalloc *= 2;
    comout = realloc ( comout, comalloc );
   }
   memmove ( comout + comlen, buffer, chread );
   comlen += chread;
  }

 //printf("COMOUT: %s",comout);fflush(stdout);
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

int
ascii ( char*  str ) {
	int count = 0;
	for ( int i =0; i < strlen (str); i++)
		count = count * 100 + (int)str[i];
	return count;	
}
