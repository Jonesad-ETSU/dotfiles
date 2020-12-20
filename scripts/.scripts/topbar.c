#define HOME "/home/jonesad"
#define SCRIPTS HOME"/.scripts"
#define FIFO HOME"/.lemonbar_top.fifo"
#define BUFFER_SIZE 150

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <unistd.h>

char* brightness();
char* mem       ();
char* home      ();
char* user      ();
char* clock     ();
char* bat       ();
char* vol       ();
int   capture   ( char*, char* );
void  format    ( char*, char*, char* );
void  module    ( char*, char*, char*, char* );

typedef struct message{
//  char *text;
  char text[BUFFER_SIZE];
} message;

int
main() { 

  message* receipt = malloc(sizeof(message));
  char /**receipt = malloc(BUFFER_SIZE),*/
       *memorystr = malloc(BUFFER_SIZE),
       *batterystr = malloc(BUFFER_SIZE),
       *homestr = malloc(BUFFER_SIZE),
       *userstr = malloc(BUFFER_SIZE),
       *clockstr = malloc(BUFFER_SIZE),
       *brightstr = malloc(BUFFER_SIZE);

  int fd;
  int dummypid,
      mempid,
      batpid,
      homepid,
      userpid,
      clockpid,
      brightpid;
   
  /* Makes named pipe  */
  if ( access ( FIFO, F_OK  ) == 0 )
    remove ( FIFO );
  mkfifo ( FIFO, 0666 );

  dummypid = fork();
  if ( dummypid == 0 ) {
    while (1) { 
      fd = open( FIFO, O_WRONLY );
      //receipt->text = mem();
      strcpy ( receipt->text, mem());
      write ( fd, receipt, sizeof ( message) );
      sleep (1);
    }
  } else if ( dummypid > 0 ) {
    mempid = dummypid;
  }

  dummypid = fork();
  if ( dummypid == 0) {
    while (1) {
      fd = open( FIFO, O_WRONLY );
      //receipt->text = bat();
      strcpy ( receipt->text, bat());
      write ( fd, receipt, sizeof ( message ));
      sleep (1);
    }
  } else if ( dummypid > 0) {
    batpid = dummypid;
  }
  
  dummypid = fork();
  if ( dummypid == 0) {
    while (1) { 
      fd = open( FIFO, O_WRONLY );
      //receipt->text = home();
      strcpy (receipt->text, home());
      write ( fd, receipt, sizeof ( message ));
      sleep (1);
    }
  } else if ( dummypid > 0) {
    homepid = dummypid;
  }

  dummypid = fork();
  if ( dummypid == 0) {
    while (1) { 
      fd = open( FIFO, O_WRONLY );
      //receipt->text = brightness();
      strcpy (receipt->text, brightness());
      write ( fd, receipt, sizeof ( message));
      sleep (1);
    }
  } else if ( dummypid > 0) {
    brightpid = dummypid;
  }
  
  dummypid = fork();
  if ( dummypid == 0) {
    while (1) {
      fd = open( FIFO, O_WRONLY );
      //receipt->text = user();
      strcpy (receipt->text, user());
      write ( fd, receipt, sizeof ( message ));
      sleep (1);
    }
  } else if ( dummypid > 0) {
    userpid = dummypid;
  }

  dummypid = fork();
  if ( dummypid == 0) {
    while (1) { 
      fd = open( FIFO, O_CREAT|O_WRONLY );
      //receipt->text = clock();
      strcpy (receipt->text,clock());
      write ( fd, receipt, sizeof ( message) );
      sleep (1);
    }
  } else if ( dummypid > 0) {
    clockpid = dummypid;
  }
  /* uses read syscall to continually read from pipe  */
  //char msg[BUFFER_SIZE];
  message* msg = malloc(sizeof(message));
  int bytesread = -1;
  fd = open ( FIFO, O_RDONLY );
  
  while ( ( bytesread = read (fd, msg, sizeof (message))) > 0) {
    /* Parses message and assigns value to correct string */
    if ( strncmp ( msg->text , "mem", 3 ) == 0 ) {
       memcpy ( memorystr, msg->text+3, strlen ( msg->text ) - 3 );
    } else if ( strncmp ( msg->text, "clock", 5 ) == 0) {
       memcpy ( clockstr, msg->text+5, strlen ( msg->text ) - 5 );
    } else if ( strncmp ( msg->text, "home", 4 ) == 0 ) {
       memcpy ( homestr, msg->text+4, strlen ( msg->text ) - 4 );
    } else if ( strncmp ( msg->text, "bat", 3 ) == 0 ) {
       memcpy ( batterystr, msg->text+3, strlen ( msg->text ) - 3 );
    } else if ( strncmp ( msg->text, "bright", 6 ) == 0 ) {
       memcpy ( brightstr, msg->text+6, strlen ( msg->text ) - 6 );
    } else if ( strncmp ( msg->text, "user", 4 ) == 0 ) {
       memcpy ( userstr, msg->text+4, strlen ( msg->text ) - 4 );
    }
    printf ("\%{c}\%{T2}%s %s \%{T1}\%{r}%s %s %s %s\n", clockstr, batterystr, homestr, memorystr, brightstr, userstr);
    fflush(stdout);
  }
  
  close (fd);

  kill (mempid,SIGTERM);
  kill (clockpid,SIGTERM);
  kill (homepid,SIGTERM);
  kill (batpid,SIGTERM);
  kill (brightpid,SIGTERM);
  kill (userpid,SIGTERM);
	return 0;
}

char*
vol() {
  char *out;
  module (SCRIPTS "/volbar.sh", "%{A:pavucontrol &:} ", " %{A}", out);
  return out;
}

char*
mem() {
  char *out;
  module (SCRIPTS "/mem.sh", "mem%{A:$TERM -e gotop &:} ", " %{A}", out);
  return out;
}

char*
home() {
  char *out;
  module (SCRIPTS "/home.sh", "home%{A:$TERM -e ncdu &:} "," %{A}", out);
  return out;
}

char*
user() {
  char *out;
  module (SCRIPTS "/id.sh", "user%{A:$TERM &:} "," %{A}", out);
  return out;
}

char*
clock() {
  char *out;
  module (SCRIPTS "/time.sh", "clock%{A:yad --calendar --mouse  &:} "," %{A}", out);
  return out;
}

char*
bat() {
  char *out;
  module (SCRIPTS "/battery.sh", "bat%{A:dunstify Battery $(cat /sys/class/power_supply/BAT0/capacity) &:} "," %{A}", out);
  return out;
}

char*
brightness() {
  char *out;
  module (SCRIPTS "/brightness.sh", "bright%{A:"SCRIPTS"/yad-bright.sh:} "," %{A}", out);
  return out;
}

/* From RosettaCode. Returns the output of cmd parm  */
int 
capture(char* cmd, char* cmdout) {
   FILE *fd;
   fd = popen(cmd, "r");
   if (!fd) return 1;

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
format (char *pre, char *post, char* middle) {
  strcat ( pre, middle );
  strcat ( pre, post );
  strcpy ( middle, pre );
}

void
module ( char* middle, char *pre, char *post, char* ret ) {
  char tmp[512], script[BUFFER_SIZE], open[BUFFER_SIZE], close[BUFFER_SIZE];
  strcpy ( script, middle );
  strcpy ( open, pre );
  strcpy ( close, post );

  capture ( script, tmp );
  format ( open, close, tmp );
  strcpy ( ret, tmp );
}
