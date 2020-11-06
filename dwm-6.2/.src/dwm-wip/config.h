/* See LICENSE file for copyright and license details. */

/* appearance */
static unsigned int borderpx  = 1;        /* border pixel of windows */
static unsigned int snap      = 32;       /* snap pixel */
static unsigned int gappih    = 10;
static unsigned int gappiv    = 10;
static unsigned int gappoh    = 10;
static unsigned int gappov    = 10;
static int smartgaps          = 1;
static int showbar            = 1;        /* 0 means no bar */
static int topbar             = 1;        /* 0 means bottom bar */
static int swallowfloating    = 1;
static int user_bh            = 0;        /* 0 means dwm will choose */
static const char statussep   = ';';
static const char *fonts[]          = { "DejaVu Sans:size=16","UbuntuMonoDerivativePowerline Nerd Font:size=22" };
static const char dmenufont[]       = "DejaVu Sans:size=16";
static char normbgcolor[]           = "#222222";
static char normbordercolor[]       = "#444444";
static char normfgcolor[]           = "#bbbbbb";
static char selfgcolor[]            = "#eeeeee";
static char selbordercolor[]        = "#005577";
static char selbgcolor[]            = "#005577";
static const char col1[]            = "#ffffff";
static const char col2[]            = "#ffffff";
static const char col3[]            = "#ffffff";
static const char col4[]            = "#ffffff";
static const char col5[]            = "#ffffff";
static const char col6[]            = "#ffffff";
static const char col7[]            = "#ffffff";
static const char col8[]            = "#ffffff";
static const char col9[]            = "#ffffff";
static const char col10[]           = "#ffffff";
static const char col11[]           = "#ffffff";
static const char col12[]           = "#ffffff";

static char *colors[][3] = {
       /*               fg           bg           border   */
       [SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
    	 [SchemeCol1]  = { col1,      normbgcolor, normbordercolor },
    	 [SchemeCol2]  = { col2,      normbgcolor, normbordercolor },
       [SchemeCol3]  = { col3,      normbgcolor, normbordercolor },
       [SchemeCol4]  = { col4,      normbgcolor, normbordercolor },
       [SchemeCol5]  = { col5,      normbgcolor, normbordercolor },
       [SchemeCol6]  = { col6,      normbgcolor, normbordercolor },
       [SchemeCol7]  = { col7,      normbgcolor, normbordercolor },
       [SchemeCol8]  = { col8,      normbgcolor, normbordercolor },
       [SchemeCol9]  = { col8,      normbgcolor, normbordercolor },
       [SchemeCol10] = { col10,     normbgcolor, normbordercolor },
       [SchemeCol11] = { col11,     normbgcolor, normbordercolor },
       [SchemeCol12] = { col12,     normbgcolor, normbordercolor },
       [SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor  },
};

/* tagging */
static const char *tags[] = { "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class     instance  title           tags mask  isfloating  isterminal  noswallow   canfocus   monitor float x,y,w,h  floatborderpx*/
	{ "GIMP",    NULL,     NULL,           0,         1,          0,           0,         1,           -1,    50,50,500,500,  5 },
	{ "Chromium", NULL,     NULL,           0,    0,          0,          1,        1,           -1,    50,50,500,500,  5 },
	{ "URxvt",      NULL,     NULL,           0,         0,          1,           0,      1,           -1,    50,50,500,500,  5 },
	{ NULL,      NULL,     "Event Tester", 0,         0,          0,           1,         1,           -1,    50,50,500,500,  5 }, /* xev */
};

/* layout(s) */
static float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static int nmaster     = 1;    /* number of clients in master area */
static int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static int attachbelow = 1;

/* mouse scroll resize */
static const int scrollsensetivity = 30; /* 1 means resize window by 1 pixel for each scroll event */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ NULL,       NULL },
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
static const char *dmenucmd[] = { "dmenu_run","-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbordercolor, "-sf", selfgcolor,"-c","-l","10",NULL };
static const char *termcmd[]  = { "urxvtc", NULL };

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
	{"attachbelow",	INTEGER,	&attachbelow},
	{"resizehints",	INTEGER,	&resizehints},
	{"mfacts",	FLOAT,		&mfact},
	//{"systraypinning",	INTEGER,	&systraypinning},
	//{"systrayspacing",	INTEGER,	&systrayspacing},
	//{"systraypinningfailfirst",	INTEGER,	&systraypinningfailfirst},
	//{"showsystray",	INTEGER,	&showsystray},
  {"gappih",	INTEGER,	&gappih},
	{"gappiv",	INTEGER,	&gappiv},
	{"gappoh",	INTEGER,	&gappoh},
	{"gappov",	INTEGER,	&gappov},
	{"smartgaps",	INTEGER,	&smartgaps},
};


#include "focusurgent.c"
static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_d,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_o,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,              XK_equal,      incrgaps,       {.i = +1 } },
	{ MODKEY,              XK_minus,      incrgaps,       {.i = -1 } },
	{ MODKEY|ShiftMask,  XK_equal,      incrigaps,      {.i = +1 } },
	{ MODKEY|ShiftMask,  XK_minus,      incrigaps,      {.i = -1 } },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,           XK_space, cyclelayout,    {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,             XK_f,      togglefullscr,  {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
  { MODKEY|ShiftMask,             XK_u,           focusurgent, {0} },
  { MODKEY|ShiftMask,             XK_q,           killclient, {0}},
	{ MODKEY|ShiftMask,             XK_Escape,      quit,           {0} },
};

/* resizemousescroll direction argument list */
static const int scrollargs[][2] = {
	/* width change         height change */
	{ +scrollsensetivity,	0 },
	{ -scrollsensetivity,	0 },
	{ 0, 				  	+scrollsensetivity },
	{ 0, 					-scrollsensetivity },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button1,        sigdwmblocks,   {.i = 1} },
	{ ClkStatusText,        0,              Button2,        sigdwmblocks,   {.i = 2} },
	{ ClkStatusText,        0,              Button3,        sigdwmblocks,   {.i = 3} },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkClientWin,         MODKEY,         Button4,        resizemousescroll, {.v = &scrollargs[0]} },
	{ ClkClientWin,         MODKEY,         Button5,        resizemousescroll, {.v = &scrollargs[1]} },
	{ ClkClientWin,         MODKEY,         Button6,        resizemousescroll, {.v = &scrollargs[2]} },
	{ ClkClientWin,         MODKEY,         Button7,        resizemousescroll, {.v = &scrollargs[3]} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
