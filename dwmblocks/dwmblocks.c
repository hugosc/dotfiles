#include<stdlib.h>
#include<stdio.h>
#include<string.h>
#include<unistd.h>
#include<signal.h>
#include<time.h>

#ifndef NO_X
#include<X11/Xlib.h>
#endif
#ifdef __OpenBSD__
#define SIGPLUS			SIGUSR1+1
#define SIGMINUS		SIGUSR1-1
#else
#define SIGPLUS			SIGRTMIN
#define SIGMINUS		SIGRTMIN
#endif
#define LENGTH(X)               (sizeof(X) / sizeof (X[0]))
#define CMDLENGTH		120
#define MIN( a, b ) ( ( a < b) ? a : b )
#define STATUSLENGTH (LENGTH(blocks) * CMDLENGTH + 1)
#define STATUSDELIMLEN (delimLen + 1)

typedef struct {
	char* icon;
	char* command;
	unsigned int interval;
	unsigned int signal;
} Block;
#ifndef __OpenBSD__
void dummysighandler(int num);
#endif
void buttonhandler(int signum, siginfo_t *si, void *ucontext);
void getcmds(time_t now);
void getsigcmds(unsigned int signal);
void setupsignals();
int getstatus(char *str, char *last);
void statusloop();
void termhandler(int sig);
void pstdout();
#ifndef NO_X
void setroot();
static void (*writestatus) () = setroot;
static int setupX();
static Display *dpy;
static int screen;
static Window root;
#else
static void (*writestatus) () = pstdout;
#endif


#include "blocks.h"

static char statusbar[LENGTH(blocks)][CMDLENGTH] = {0};
static char statusstr[2][STATUSLENGTH];
static int statusContinue = 1;
static unsigned int blockButton = 0;
static time_t lastRun[LENGTH(blocks)] = {0};

//opens process *cmd and stores output in *output
void getcmd(const Block *block, char *output)
{
	//make sure status is same until output is ready
	char tempstatus[CMDLENGTH] = {0};
	strcpy(tempstatus, block->icon);
	
	// Set BLOCK_BUTTON environment variable
	char button_str[16];
	snprintf(button_str, sizeof(button_str), "%d", blockButton);
	setenv("BLOCK_BUTTON", button_str, 1);
	
	FILE *cmdf = popen(block->command, "r");
	if (!cmdf)
		return;
	int i = strlen(block->icon);
	int reserved = (delim[0] != '\0') ? (delimLen + 2) : 1; /* delim + signal + NUL (or just NUL) */
	int maxlen = CMDLENGTH - i - reserved;
	if (maxlen > 0)
		fgets(tempstatus+i, maxlen, cmdf);
	i = strlen(tempstatus);
	//if block and command output are both not empty
	if (i != 0) {
		//only chop off newline if one is present at the end
		i = tempstatus[i-1] == '\n' ? i-1 : i;
		if (delim[0] != '\0') {
			memcpy(tempstatus+i, delim, delimLen);
			i += delimLen;
			tempstatus[i++] = (char)block->signal;
		}
		tempstatus[i] = '\0';
	}
	strcpy(output, tempstatus);
	pclose(cmdf);
	blockButton = 0;  // Reset after command execution
}

void getcmds(time_t now)
{
	const Block* current;
	for (unsigned int i = 0; i < LENGTH(blocks); i++) {
		current = blocks + i;
		if (now == (time_t)-1) {
			getcmd(current, statusbar[i]);
			lastRun[i] = time(NULL);
			continue;
		}
		if (current->interval == 0)
			continue;
		if (lastRun[i] == 0 || now - lastRun[i] >= (time_t)current->interval) {
			getcmd(current, statusbar[i]);
			lastRun[i] = now;
		}
	}
}

void getsigcmds(unsigned int signal)
{
	const Block *current;
	for (unsigned int i = 0; i < LENGTH(blocks); i++) {
		current = blocks + i;
		if (current->signal == signal)
			getcmd(current,statusbar[i]);
	}
}


void setupsignals()
{
#ifndef __OpenBSD__
	/* initialize all real time signals with dummy handler */
	for (int i = SIGRTMIN; i <= SIGRTMAX; i++)
		signal(i, dummysighandler);
#endif

	struct sigaction sa;
	memset(&sa, 0, sizeof(sa));
	sa.sa_sigaction = buttonhandler;
	sa.sa_flags = SA_SIGINFO;
	sigemptyset(&sa.sa_mask);

	for (unsigned int i = 0; i < LENGTH(blocks); i++) {
		if (blocks[i].signal > 0)
			sigaction(SIGMINUS + blocks[i].signal, &sa, NULL);
	}
}

int getstatus(char *str, char *last)
{
	strcpy(last, str);
	str[0] = '\0';
	for (unsigned int i = 0; i < LENGTH(blocks); i++)
		strcat(str, statusbar[i]);
	int len = strlen(str);
	int dlen = (delim[0] != '\0') ? (int)delimLen + 1 : 0; /* visible delim + signal char */
	if (len >= dlen && dlen > 0) {
		str[len - dlen] = '\0';
	}
	return strcmp(str, last);//0 if they are the same
}

#ifndef NO_X
void setroot()
{
	if (!getstatus(statusstr[0], statusstr[1]))//Only set root if text has changed.
		return;
	XStoreName(dpy, root, statusstr[0]);
	XFlush(dpy);
}

int setupX()
{
	dpy = XOpenDisplay(NULL);
	if (!dpy) {
		fprintf(stderr, "dwmblocks: Failed to open display\n");
		return 0;
	}
	screen = DefaultScreen(dpy);
	root = RootWindow(dpy, screen);
	return 1;
}
#endif

void pstdout()
{
	if (!getstatus(statusstr[0], statusstr[1]))//Only write out if text has changed.
		return;
	printf("%s\n",statusstr[0]);
	fflush(stdout);
}


void statusloop()
{
	setupsignals();
	getcmds((time_t)-1);
	while (1) {
		time_t now = time(NULL);
		getcmds(now);
		writestatus();
		if (!statusContinue)
			break;
		sleep(1);
	}
}

#ifndef __OpenBSD__
/* this signal handler should do nothing */
void dummysighandler(int signum)
{
    return;
}
#endif

void buttonhandler(int signum, siginfo_t *si, void *ucontext)
{
	(void)ucontext;
	blockButton = si ? (unsigned int)si->si_value.sival_int : 0;
	getsigcmds(signum - SIGPLUS);
	writestatus();
}

void termhandler(int sig)
{
	statusContinue = 0;
}

int main(int argc, char** argv)
{
	for (int i = 0; i < argc; i++) {//Handle command line arguments
		if (!strcmp("-d",argv[i]))
			strncpy(delim, argv[++i], delimLen);
		else if (!strcmp("-p",argv[i]))
			writestatus = pstdout;
	}
#ifndef NO_X
	if (!setupX())
		return 1;
#endif
	delimLen = MIN(delimLen, strlen(delim));
	signal(SIGTERM, termhandler);
	signal(SIGINT, termhandler);
	statusloop();
#ifndef NO_X
	XCloseDisplay(dpy);
#endif
	return 0;
}
