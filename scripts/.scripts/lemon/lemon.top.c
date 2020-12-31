#define HOME "/home/jonesad"
#define LEMON HOME"/.scripts/lemon"
#define FIFO HOME"/.lemonbar_top.fifo"
#define BUFFER_SIZE 450
#define DELIM "  "

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <unistd.h>

typedef struct message {
  char text[BUFFER_SIZE];
} message;

typedef struct module {
  char cmd[BUFFER_SIZE];
  char id[10];
  char pre[BUFFER_SIZE];
  char post[BUFFER_SIZE];
  int timer;
  int signum;
} module;

void  reader  (   );
void  send    ( char*, int );
void  exec    ( module );
void  format  ( char*, char*, char*, char*, char* );
int   capture ( char*, char* );


int
main() {
  int modnum = 1;  
  struct module battery = 
    { LEMON"/lemon-battery.sh", "bat", "", "", 60, modnum++ };
  struct module time = 
    { LEMON"/lemon-time.sh", "time", "", "", 30, modnum++ };
  struct module user = 
    { LEMON"/lemon-id.sh", "user", "", "", 360, modnum++ };
  struct module brightness = 
    { LEMON"/lemon-brightness.sh", "bright", "", "", 30, modnum++};
  struct module home = 
    { LEMON"/lemon-home.sh", "home", "", "", 120, modnum++ };
  struct module mem = 
    { LEMON"/lemon-mem.sh", "mem", "", "", 2, modnum++ };
  struct module tags = 
    { LEMON"/lemon-ewmh.sh", "tags", "", "", 0, modnum++ };
  struct module vol = 
    { LEMON"/lemon-volbar.sh", "vol", "", "", 2, modnum };
  

  /* Makes named pipe  */
  if ( access ( FIFO, F_OK  ) == 0 )
    remove ( FIFO );
  mkfifo ( FIFO, 0666 );

  exec(battery);
  exec(time);
  exec(user);
  exec(brightness);
  exec(home);
  exec(mem);
  exec(tags);
  //exec(vol);

  reader();
}

void
reader() {

  message* msg        = malloc(sizeof(message));
  char  *memorystr    = malloc(BUFFER_SIZE),
        *batterystr   = malloc(BUFFER_SIZE),
        *homestr      = malloc(BUFFER_SIZE),
        *userstr      = malloc(BUFFER_SIZE),
        *timestr      = malloc(BUFFER_SIZE),
        *tagstr       = malloc(BUFFER_SIZE),
        *brightstr    = malloc(BUFFER_SIZE);

  int bytesread = -1 ,
      fd        = open ( FIFO, O_RDONLY );

  while ( ( bytesread = read (fd, msg, sizeof (message))) > 0) {
  /* Parses message and assigns value to correct string */
    if ( strncmp ( msg->text , "mem", 3 ) == 0 ) {
      memcpy ( memorystr, msg->text+3, strlen ( msg->text ) - 3 );
      memorystr[ strlen (msg->text) ] = '\0';
    } else if ( strncmp ( msg->text, "time", 4 ) == 0) {
      memcpy ( timestr, msg->text+4, strlen ( msg->text ) - 4 );
      timestr[ strlen (msg->text) ] = '\0';
    } else if ( strncmp ( msg->text, "tags", 4 ) == 0 ) {
      memcpy ( tagstr, msg->text+4, strlen ( msg->text ) - 4 );
      tagstr[ strlen (msg->text) ] = '\0';
    } else if ( strncmp ( msg->text, "home", 4 ) == 0 ) {
      memcpy ( homestr, msg->text+4, strlen ( msg->text ) - 4 );
      homestr[ strlen (msg->text) ] = '\0';
    } else if ( strncmp ( msg->text, "bat", 3 ) == 0 ) {
      memcpy ( batterystr, msg->text+3, strlen ( msg->text ) - 3 );
      batterystr[ strlen (msg->text) ] = '\0';
    } else if ( strncmp ( msg->text, "bright", 6 ) == 0 ) {
      memcpy ( brightstr, msg->text+6, strlen ( msg->text ) - 6 );
      brightstr[ strlen (msg->text) ] = '\0';
    } else if ( strncmp ( msg->text, "user", 4 ) == 0 ) {
      memcpy ( userstr, msg->text+4, strlen ( msg->text ) - 4 );
      userstr[ strlen (msg->text) ] = '\0';
    }

    printf ("\%{c}%s \%{r}%s"DELIM"%s"DELIM"%s"DELIM"%s"DELIM"%s\%{l}%s\n", batterystr, homestr, memorystr, brightstr, userstr, timestr, tagstr);
    fflush(stdout);
  }
}

void
send ( char* msg, int out ) {
  message* receipt = malloc(sizeof(message));
  strcpy  ( receipt->text, msg );
  write   ( out, receipt, sizeof(message));
  free    ( receipt);
}

void
exec ( module m ) {

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
      capture ( m.cmd, tmp );
      format  ( tmp, m.id, m.pre, m.post, tmp );
      send    ( tmp , fd);    
      
      if (m.timer == -1) {
        break;
      }

      sleep   ( m.timer );
    } while (1);
  } else {
     
  }
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
 cmdout [ strlen ( cmdout ) - 1 ] = 0x00;
 free   (comout);
 pclose (fd);
}
  
void
format(char* script, char* id, char* pre, char* post, char* out) {
  char tmp[BUFFER_SIZE];
  strcpy ( tmp, id );
  strcat ( tmp, pre );
  strcat ( tmp, script );
  strcat ( tmp, post );
  strcpy ( out, tmp );
}
