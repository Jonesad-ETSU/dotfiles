//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
  //{"",      "/home/jonesad/.scripts/draw-vol-bar.sh $(( $(pamixer --get-volume) / 10 )) 8 $(pamixer --get-mute > /dev/null 2>&1 && echo 'X' || echo '#')",          10,         11},
	{"   ", "date '+%a, %I:%M%p'",					5,		0},
  //Version which diffrentiaties between charging or not 
  //{"",    "/home/jonesad/.scripts/draw-battery.sh $(cat /sys/class/power_supply/BAT0/capacity) 5 $( [ $(cat /sys/class/power_supply/BAT0/status) = 'Discharging' ] && echo 1 || echo 0)*/ ", 10, 11},
  {"",    "/home/jonesad/.scripts/draw-battery.sh $(cat /sys/class/power_supply/BAT0/capacity) 5 1", 10, 11},
  {";","",0,0},
  {" ",	"free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",	30,	0},
  {"   ", "df -h | awk '/nvme0n1p3/ { print $3\"/\"$2 }'", 30, 0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "  ";
static unsigned int delimLen = 2;
