#define HOME "/home/jonesad"
#define SCRIPTS HOME"/.scripts"
#define FIFO HOME"/.lemonbar_top.fifo"
#define BUFFER_SIZE 150
#define NUM_MODULES 7

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
void  make      ( char*, char*, char*, int );

typedef struct message{
//  char *text;
  char text[BUFFER_SIZE];
} message;

int pids[NUM_MODULES];
int pidCounter = 0;

int
main() { 

  char *memorystr = malloc(BUFFER_SIZE),
       *batterystr = malloc(BUFFER_SIZE),
       *homestr = malloc(BUFFER_SIZE),
       *userstr = malloc(BUFFER_SIZE),
       *clockstr = malloc(BUFFER_SIZE),
       *brightstr = malloc(BUFFER_SIZE);

  int fd;
       
  /* Makes named pipe  */
  if ( access ( FIFO, F_OK  ) == 0 )
    remove ( FIFO );
  mkfifo ( FIFO, 0666 );

//make (SCRIPTS "/volbar.sh", "%{A:pavucontrol &:} ", " %{A}", 5);
  make (SCRIPTS "/mem.sh", "mem%{A:$TERM -e gotop &:} ", " %{A}", 5);
  make (SCRIPTS "/home.sh", "home%{A:$TERM -e ncdu &:} "," %{A}", 5);
  make (SCRIPTS "/id.sh", "user%{A:$TERM &:} "," %{A}", 10000);
  make (SCRIPTS "/time.sh", "clock%{A:yad --calendar --mouse  &:} "," %{A}", 30);
  make (SCRIPTS "/battery.sh", "bat%{A:dunstify Battery $(cat /sys/class/power_supply/BAT0/capacity) &:} "," %{A}", 10);
  make (SCRIPTS "/brightness.sh", "bright%{A:"SCRIPTS"/yad-bright.sh:} "," %{A}", 1);
  
  /* uses read syscall to continually read from pipe  */
  message* msg = malloc(sizeof(message));
  int bytesread = -1;
  fd = open ( FIFO, O_RDONLY );
  
  while ( ( bytesread = read (fd, msg, sizeof (message))) > 0) {
    /* Parses message and assigns value to correct string */
    printf("msg->text: %s\n",msg->text);
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

  for (int i = 0; i < NUM_MODULES;++i)
    kill (pids[i],  SIGTERM);

	return 0;
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

void
make ( char* middle, char* pre, char* post, int timer) {
  message* receipt = malloc(sizeof(message));
  char *out;
  int dummypid, fd;
  dummypid = fork ();
  if ( dummypid == 0 ) {
    while ( 1 ) {
      printf("In child loop");
      fflush(stdout);
      fd = open( FIFO, O_WRONLY);
      module ( middle, pre, post, out);
      printf ("module Returns: %s\n",out);
      fflush ( stdout );
      strcpy ( receipt->text, out);
      write  ( fd, receipt, sizeof ( message ));
      sleep  ( timer );
    } 
  } else { 
    pids[pidCounter] = dummypid;
    pidCounter++;
  }
}
