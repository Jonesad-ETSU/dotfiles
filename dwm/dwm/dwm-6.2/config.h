/* See LICENSE file for copyright and license details. */
#include "tcl.c"
#include <X11/XF86keysym.h>
#define HOME "/home/jonesad"
#define WALL "/home/jonesad/Wallpaper"
/* appearance */
static unsigned int borderpx  = 1;        /* border pixel of windows */
static unsigned int snap      = 32;       /* snap pixel */
static int swallowfloating    = 0;
static unsigned int systraypinning = 0;
static unsigned int systrayspacing = 2;
static unsigned int systraypinningfailfirst = 1;
static unsigned int showsystray = 0;
static unsigned int gappih    = 10;       /* horiz inner gap between windows */
static unsigned int gappiv    = 10;       /* vert inner gap between windows */
static unsigned int gappoh    = 10;       /* horiz outer gap between windows and screen edge */
static unsigned int gappov    = 10;       /* vert outer gap between windows and screen edge */
static int smartgaps          = 1;        /* 1 means no outer gap when there is only one window */
static int showbar            = 1;        /* 0 means no bar */
static int topbar             = 1;        /* 0 means bottom bar */
static int user_bh            = 0;        /* 0 means auto calculate*/
static const char *fonts[]          = { "DejaVu Sans:size=12","UbuntuMonoDerivativePowerline Nerd Font:size=22" };
static const char dmenufont[]       = "DejaVu Sans:size=16";
static char normbgcolor[]       = "#222222";
static char normbordercolor[]       = "#444444";
static char normfgcolor[]       = "#bbbbbb";
static char selfgcolor[]       = "#eeeeee";
static char selbordercolor[]        = "#005577";
static char selbgcolor[]	= "#005577";
static char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
	[SchemeSel]  = { selfgcolor, selbgcolor,  selbordercolor  },
	[SchemeHid]  = { normfgcolor,  normbgcolor, selbgcolor  },
};

/* tagging */
static const char *tags[] = { "I", "II", "III", "IV", "V", "VI", "VII", "VIII","IX" };

static const Rule rules[] = {
	/* xprop(1):)
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags    center   floating term  noswallow monitor */
	{ "Gimp",     NULL,       NULL,       0,      1,	     1,       0,    0,        -1 },
	{ "Steam",    NULL,	      NULL,	      0,	    1,	     1,		    0,    0,        -1 },
  { "URxvt",    NULL,       NULL,       0,      0,       0,       1,    0,        -1 },
	{ "Arandr",   NULL,	      NULL,	      0, 	    1,	     1,	      0,    0,        -1 },
};

/* layout(s) */
static float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static int nmaster     = 1;    /* number of clients in master area */
static int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "T",      tile },    /* first entry is default */
	{ "M",      monocle },
	{ "B",      bstack },
	{ "3",      tcl },
	{ "F",	      NULL},
	{ NULL,	      NULL},
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", normbgcolor, "-sf", selfgcolor,"-c","-l","10", NULL };
static const char * custdmenucmd[] = {HOME "/.scripts/dmenu/launch-dmenu.sh","dmenu-gen",NULL};
static const char *termcmd[]  = { "urxvtc", NULL };
static const char *filescmd[] = {"urxvtc","-e","ranger",NULL};
static const char *randomwallcmd[] = {HOME "/.scripts/set-random-wallpaper.sh",NULL};
static const char *audiocmds[][3] = {  {HOME "/.scripts/mute.sh",NULL},
				       {HOME "/.scripts/raise-volume.sh",NULL },
				       {HOME "/.scripts/lower-volume.sh",NULL } };
static char *statuscmds[] = {"notify-send Mouse$BUTTON"};
static char *statuscmd[] = {"/bin/sh","-c",NULL,NULL};
static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_d,      spawn,          {.v = dmenucmd } },
	{ MODKEY,	                XK_Return, spawn,          {.v = custdmenucmd } },
	{ MODKEY|ShiftMask,		XK_Return,	spawn,		{.v = termcmd} },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_p,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_o,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.01} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.01} },
	{ MODKEY|ShiftMask,             XK_space,  zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_q,      killclient,     {0} },
	{ MODKEY,			                  XK_e,	     spawn,	         {.v = filescmd} },
	{ MODKEY,                       XK_space,  cyclelayout,    {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_f,      togglefloating, {0} },
	{ MODKEY,             		      XK_f,      togglefullscr,  {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY|ShiftMask,		          XK_Home,	 spawn,      	   {.v = randomwallcmd} },
	{ MODKEY,			                  XK_equal,	 incrgaps,		   {.i = +5}},
	{ MODKEY,			                  XK_minus,	 incrgaps,	     {.i = -5}},
  { MODKEY|ShiftMask,             XK_equal,  incrigaps,      {.i = +5}},
  { MODKEY|ShiftMask,             XK_minus,  incrigaps,      {.i = -5}},
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_Escape,      quit,      {0} },
	{ MODKEY,			                  XK_F1,		      spawn,	   {.v = audiocmds[0]} },
	{ 0,		 	                      XF86XK_AudioRaiseVolume,	 spawn,   {.v=audiocmds[1]} },
	{ 0, 			                      XF86XK_AudioLowerVolume,	 spawn,   {.v = audiocmds[2]} }, 
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        cyclelayout,    {.i = +1} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button1,        togglewin,      {0} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button1,        spawn,          {.v = statuscmd } },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = statuscmd } },
	{ ClkStatusText,        0,              Button3,        spawn,          {.v = statuscmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

/*
 * Xresources preferences to load at startup
 */

ResourcePref resources[] = {
	{"background",	 STRING,	&normbgcolor },
	{"background", STRING, &normbordercolor },
	{"foreground",	 STRING,	&normfgcolor},
	{"background",	 STRING, &selbgcolor},
	{"color14", STRING, &selbordercolor},	
	{"color14",	STRING, &selfgcolor},
  {"swallowfloating", INTEGER, &swallowfloating},
	{"borderpx",	INTEGER,	&borderpx},
	{"snap",	INTEGER,	&snap},
	{"showbar",	INTEGER,	&showbar},
	{"topbar",	INTEGER,	&topbar},
  {"user_bh", INTEGER,  &user_bh},
	{"nmaster",	INTEGER,	&nmaster},
	{"resizehints",	INTEGER,	&resizehints},
	{"mfacts",	FLOAT,		&mfact},
	{"systraypinning",	INTEGER,	&systraypinning},
	{"systrayspacing",	INTEGER,	&systrayspacing},
	{"systraypinningfailfirst",	INTEGER,	&systraypinningfailfirst},
	{"showsystray",	INTEGER,	&showsystray},
	{"gappih",	INTEGER,	&gappih},
	{"gappiv",	INTEGER,	&gappiv},
	{"gappoh",	INTEGER,	&gappoh},
	{"gappov",	INTEGER,	&gappov},
	{"smartgaps",	INTEGER,	&smartgaps},
};
