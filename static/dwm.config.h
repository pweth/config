// Appearance
static const unsigned int borderpx = 0;
static const unsigned int snap     = 32;
static const int showbar           = 1;
static const int topbar            = 1;
static const int splitstatus       = 1;
static const float mfact           = 0.55;
static const int nmaster           = 1;
static const int resizehints       = 0;
static const int lockfullscreen    = 1;
static const char *splitdelim      = ";";
static const char *fonts[]         = { "Hack:size=13" };
static const char *colors[][3]     = {
	[SchemeNorm] = { "#bbbbbb", "#191919", "#444444" },
	[SchemeSel]  = { "#eeeeee", "#191919", "#191919" },
};

static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	// class      instance    title       tags mask     isfloating   monitor
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
};

static const Layout layouts[] = {
	{ "[]=", tile },
	{ "><>", NULL },
	{ "[M]", monocle },
};

// Key definitions
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY, view,       {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY, toggleview, {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY, tag,        {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY, toggletag,  {.ui = 1 << TAG} },

#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

// Commands
static char dmenumon[2] = "0";
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, NULL };
static const char *termcmd[]  = { "st", "-e", "/run/current-system/sw/bin/tmux", NULL };

static const Key keys[] = {
	// Window management
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_g,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_h,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_w,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_y,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },

	// Programs
	{ MODKEY, XK_c,      spawn, SHCMD("galculator") },
	{ MODKEY, XK_e,      spawn, SHCMD("emote") },
	{ MODKEY, XK_f,      spawn, SHCMD("firefox") },
	{ 0,      XK_Print,  spawn, SHCMD("flameshot gui") },

	// Volume control
	{ 0, 0x1008FF11, spawn, SHCMD("amixer set Master 10%-") },
	{ 0, 0x1008FF12, spawn, SHCMD("amixer set Master toggle") },
	{ 0, 0x1008FF13, spawn, SHCMD("amixer set Master 10%+") },

	// Media player control
	{ 0, 0x1008FF14, spawn, SHCMD("playerctl play-pause") },
	{ 0, 0x1008FF16, spawn, SHCMD("playerctl previous") },
	{ 0, 0x1008FF17, spawn, SHCMD("playerctl next") },

	// System control
	{ MODKEY,                       XK_l, spawn, SHCMD("slock") },
	{ MODKEY|ControlMask|ShiftMask, XK_p, spawn, SHCMD("shutdown now") },
	{ MODKEY|ControlMask|ShiftMask, XK_r, spawn, SHCMD("shutdown now --reboot") },
	{ MODKEY|ControlMask|ShiftMask, XK_q, quit,  {0} },

	// Tags
	TAGKEYS(XK_1, 0)
	TAGKEYS(XK_2, 1)
	TAGKEYS(XK_3, 2)
	TAGKEYS(XK_4, 3)
	TAGKEYS(XK_5, 4)
	TAGKEYS(XK_6, 5)
	TAGKEYS(XK_7, 6)
	TAGKEYS(XK_8, 7)
	TAGKEYS(XK_9, 8)
};

// Button definitions
static const Button buttons[] = {
	{ ClkLtSymbol,   0,      Button1, setlayout,      {0} },
	{ ClkLtSymbol,   0,      Button3, setlayout,      {.v = &layouts[2]} },
	{ ClkClientWin,  MODKEY, Button1, movemouse,      {0} },
	{ ClkClientWin,  MODKEY, Button2, togglefloating, {0} },
	{ ClkClientWin,  MODKEY, Button3, resizemouse,    {0} },
	{ ClkTagBar,     0,      Button1, view,           {0} },
	{ ClkTagBar,     0,      Button3, toggleview,     {0} },
	{ ClkTagBar,     MODKEY, Button1, tag,            {0} },
	{ ClkTagBar,     MODKEY, Button3, toggletag,      {0} },
};
