//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
  //{"[ ", "date '+%y-%m-%d'", 3600, 0},
  {"[  ", "date '+%I:%M%p'",					5,		0},
  {" ","/home/jonesad/.scripts/parse-weather.sh",		900,		0}, 
  {"  ", "df -h | awk '/nvme0n1p3/ { print $3\"/\"$2 }'",	30,		0},
  {"  ",	"free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",	30,	0},
  {"",      "/home/jonesad/.scripts/draw-vol-bar.sh $(( $(pamixer --get-volume) / 10 )) 8 $(pamixer --get-mute > /dev/null 2>&1 && echo 'X' || echo '#')",          10,         10},
  {"",    "/home/jonesad/.scripts/draw-battery.sh",	 10,	 11},
  {"   ", "/home/jonesad/.scripts/whoami.sh",		0,	0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " ] [ ";
static unsigned int delimLen = 5;
