/* See LICENSE file for copyright and license details. */

/* appearance */
static unsigned int borderpx  = 1;        /* border pixel of windows */
static unsigned int snap      = 32;       /* snap pixel */
static unsigned int gappih    = 20;       /* horiz inner gap between windows */
static unsigned int gappiv    = 10;       /* vert inner gap between windows */
static unsigned int gappoh    = 10;       /* horiz outer gap between windows and screen edge */
static unsigned int gappov    = 30;       /* vert outer gap between windows and screen edge */
static int smartgaps          = 0;        /* 1 means no outer gap when there is only one window */
static int showbar            = 1;        /* 0 means no bar */
static int topbar             = 1;        /* 0 means bottom bar */
static int user_bh            = 0;        /* 0 means that dwm will calculate bar height, >= 1 means dwm will user_bh as bar height */
static char font[]	      = "Ubuntu Nerd Font:size=16";
static char *fonts[]	      = { font };
static char dmenufont[]       = "monospace:size=10";
static char normbgcolor[]       = "#222222";
static char normbordercolor[]       = "#444444";
static char normfgcolor[]       = "#bbbbbb";
static char statusfgcolor[]       = "#bbbbbb";
static char statusbgcolor[]       = "#444444";
static char tagsselfgcolor[]       = "#bbbbbb";
static char tagsselbgcolor[]       = "#444444";
static char tagsnormfgcolor[]       = "#bbbbbb";
static char tagsnormbgcolor[]       = "#444444";
static char infoselfgcolor[]       = "#bbbbbb";
static char infoselbgcolor[]       = "#444444";
static char infonormfgcolor[]       = "#bbbbbb";
static char infonormbgcolor[]       = "#444444";
static char selfgcolor[]       = "#eeeeee";
static char selbordercolor[]        = "#005577";
static char selbgcolor[]        = "#005577";
static const unsigned int baralpha = 0xEA;
static const unsigned int borderalpha = OPAQUE;
static char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor},
	[SchemeSel]  = { selfgcolor, selbgcolor,  selbordercolor  },
	[SchemeStatus]  = { statusfgcolor, statusbgcolor,  "#000000"  }, // Statusbar right {text,background,not used but cannot be empty}
	[SchemeTagsSel]  = { tagsselfgcolor, tagsselbgcolor,  "#000000"  }, // Tagbar left selected {text,background,not used but cannot be empty}
    	[SchemeTagsNorm]  = { tagsnormfgcolor, tagsnormbgcolor,  "#000000"  }, // Tagbar left unselected {text,background,not used but cannot be empty}
    	[SchemeInfoSel]  = { infoselfgcolor, infoselbgcolor,  "#000000"  }, // infobar middle  selected {text,background,not used but cannot be empty}
    	[SchemeInfoNorm]  = { infonormfgcolor, infonormbgcolor,  "#000000"  }, // infobar middle  unselected {text,background,not used but cannot be empty}
};
static unsigned int alphas[][3]      = {
	/*               fg      bg        border     */
	[SchemeNorm] = { OPAQUE, baralpha, borderalpha },
	[SchemeSel]  = { OPAQUE, baralpha, borderalpha },
	[SchemeStatus]  = { OPAQUE, baralpha, borderalpha },
	[SchemeTagsSel]  = { OPAQUE, baralpha, borderalpha },
	[SchemeTagsNorm]  = { OPAQUE, baralpha, borderalpha },
	[SchemeInfoSel]  = { OPAQUE, baralpha, borderalpha },
	[SchemeInfoNorm]  = { OPAQUE, baralpha, borderalpha },
};

/* tagging */
static char tag1[] = "";
static char tag2[] = "";
static char tag3[] = "";
static char tag4[] = "";
static char tag5[] = "";
static char tag6[] = "";
static char tag7[] = "";
static char tag8[] = "";
static char tag9[] = "";
static char *tags[] = { tag1,tag2,tag3,tag4,tag5,tag6,tag7,tag8,tag9 };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "Firefox",  NULL,       NULL,       0,       0,           -1 },
	{ "Steam",      NULL,	  NULL,	      1 << 1,	1,	-1},
	{ "Arandr",	NULL,	NULL,		0,	1,	-1},
};

/* layout(s) */
static float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static int nmaster     = 1;    /* number of clients in master area */
static int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

#define FORCE_VSPLIT 1  /* nrowgrid layout: force two clients to always split vertically */
#include "vanitygaps.c"

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "[M]",      monocle },
	//{ "[@]",      spiral },
	{ "[\\]",     dwindle },
	{ "H[]",      deck },
	{ "TTT",      bstack },
	{ "===",      bstackhoriz },
	{ "HHH",      grid },
	//{ "###",      nrowgrid },
	{ "---",      horizgrid },
	{ ":::",      gaplessgrid },
	{ "|M|",      centeredmaster },
	{ ">M>",      centeredfloatingmaster },
	{ "><>",      NULL },    /* no layout function means floating behavior */
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
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbordercolor, "-sf", selfgcolor, NULL };
//static char terminal[] =  "xterm";
//static char *termcmd[]  = { terminal, NULL };*/
static char *termcmd[] = { "alacritty", NULL };

/*
 * Xresources preferences to load at startup
 */
ResourcePref resources[] = {
		{ "normbgcolor",        STRING,  &normbgcolor },
		{ "normbordercolor",    STRING,  &normbordercolor },
		{ "normfgcolor",        STRING,  &normfgcolor },
		{ "selbgcolor",         STRING,  &selbgcolor },
		{ "selbordercolor",     STRING,  &selbordercolor },
		{ "selfgcolor",         STRING,  &selfgcolor },
		{ "statusfgcolor",         STRING,  &statusfgcolor },
		{ "statusbgcolor",         STRING,  &statusbgcolor },
		{ "tagsselfgcolor",         STRING,  &tagsselfgcolor },
		{ "tagsselbgcolor",         STRING,  &tagsselbgcolor },
		{ "tagsnormfgcolor",         STRING,  &tagsnormfgcolor },
		{ "tagsnormbgcolor",         STRING,  &tagsnormbgcolor },
		{ "infoselfgcolor",         STRING,  &infoselfgcolor },
		{ "infoselbgcolor",         STRING,  &infoselbgcolor },
		{ "infonormfgcolor",         STRING,  &infonormfgcolor },
		{ "infonormbgcolor",         STRING,  &infonormbgcolor },
		{ "font",         		STRING,  &font},
		//{ "buttonbar",		STRING,  &buttonbar},
		//{ "buttoncmd",		STRING,  &bcmd},
		//{ "font",		STRING,  &font},
		{ "dmenufont",		STRING,  &dmenufont},
		{ "tag1",		STRING,  &tag1},
		{ "tag2",		STRING,  &tag2},
		{ "tag3",		STRING,  &tag3},
		{ "tag4",		STRING,  &tag4},
		{ "tag5",		STRING,  &tag5},
		{ "tag6",		STRING,  &tag6},
		{ "tag7",		STRING,  &tag7},
		{ "tag8",		STRING,  &tag8},
		{ "tag9",		STRING,  &tag9},
		//{ "terminal",		STRING,  &terminal},
		{ "borderpx",          	INTEGER, &borderpx },
		{ "snap",          	INTEGER, &snap },
		{ "showbar",          	INTEGER, &showbar },
		{ "user_bh",		INTEGER, &user_bh},
		//{ "swallowfloating",		INTEGER, &swallowfloating},
		{ "gappih",          	INTEGER, &gappih },
		{ "gappiv",          	INTEGER, &gappiv },
		{ "gappoh",          	INTEGER, &gappoh },
		{ "gappov",          	INTEGER, &gappov },
		{ "topbar",          	INTEGER, &topbar },
		{ "nmaster",          	INTEGER, &nmaster },
		{ "resizehints",       	INTEGER, &resizehints },
		{ "mfact",      	 	FLOAT,   &mfact },
};

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_h,      setcfact,       {.f = +0.25} },
	{ MODKEY|ShiftMask,             XK_l,      setcfact,       {.f = -0.25} },
	{ MODKEY|ShiftMask,             XK_o,      setcfact,       {.f =  0.00} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY|Mod4Mask,              XK_u,      incrgaps,       {.i = +1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_u,      incrgaps,       {.i = -1 } },
	{ MODKEY|Mod4Mask,              XK_i,      incrigaps,      {.i = +1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_i,      incrigaps,      {.i = -1 } },
	{ MODKEY|Mod4Mask,              XK_o,      incrogaps,      {.i = +1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_o,      incrogaps,      {.i = -1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_0,      defaultgaps,    {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_q,      killclient,     {0} },
	{ MODKEY,			XK_space,  cyclelayout,    {.i = -1 } },
	{ MODKEY|ShiftMask,	        XK_space,  cyclelayout,    {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_f,  	   togglefloating, {0} },
	{ MODKEY,	                XK_f,      togglefullscr,  {0} },
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
	{ MODKEY|ShiftMask,             XK_Escape,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        cyclelayout,      {.i = +1 } },
	{ ClkLtSymbol,          0,              Button3,        cyclelayout,      {.i = -1 } },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button1,        sigdwmblocks,   {.i = 1} },
	{ ClkStatusText,        0,              Button2,        sigdwmblocks,   {.i = 2} },
	{ ClkStatusText,        0,              Button3,        sigdwmblocks,   {.i = 3} },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

