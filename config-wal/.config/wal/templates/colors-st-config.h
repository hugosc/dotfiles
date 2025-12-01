/* Terminal colors (16 first used in escape sequence) - Pywal colors */
static const char *colorname[] = {{
	/* 8 normal colors */
	"{color0}", /* black   */
	"{color1}", /* red     */
	"{color2}", /* green   */
	"{color3}", /* yellow  */
	"{color4}", /* blue    */
	"{color5}", /* magenta */
	"{color6}", /* cyan    */
	"{color7}", /* white   */

	/* 8 bright colors */
	"{color8}",  /* black   */
	"{color9}",  /* red     */
	"{color10}", /* green   */
	"{color11}", /* yellow  */
	"{color12}", /* blue    */
	"{color13}", /* magenta */
	"{color14}", /* cyan    */
	"{color15}", /* white   */

	[255] = 0,

	/* more colors can be added after 255 to use with DefaultXX */
	"{foreground}", /* 256 -> cursor */
	"{background}", /* 257 -> reverse cursor */
	"{foreground}", /* 258 -> foreground */
	"{background}", /* 259 -> background */
}};
