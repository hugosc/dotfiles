//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	// {"", "~/.config/scripts/statusbar/colorscheme",			0,		8},
	{"", "~/.config/scripts/statusbar/screenrecord",			1,		12},
	{"", "~/.config/scripts/statusbar/musicplaying",			0,		11},
	{"", "~/.config/scripts/statusbar/weather",				1200,		0},
	{"", "~/.config/scripts/statusbar/wifi",				30,		0},
	{"", "~/.config/scripts/statusbar/battery",				120,		0},
	{"", "~/.config/scripts/statusbar/timedate",			60,		0},
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 3;
