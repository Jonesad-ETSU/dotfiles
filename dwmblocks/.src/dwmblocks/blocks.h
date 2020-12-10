//Modify this file to change what commands output to your statusbar, and recompile using the make command.
#define scripts "/home/jonesad/.scripts/"
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
//{"[ ", "date '+%y-%m-%d'", 3600,	0},
  {" ", scripts "time.sh" ,	5,	0},
//{" ",	scripts "weather.sh",	900,	0}, 
  {" ", scripts "home.sh",	30,	0},
  {" ", scripts "mem.sh",	30,	0},
//{" ", scripts "volbar.sh" 2>/dev/null,	10,	10},
  {" ",	scripts "id.sh",	0,	0},
  {" ", scripts "battery.sh",	 10,	 11},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "  ";
static unsigned int delimLen = 2;
