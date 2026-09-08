#!/usr/bin/env python3
"""Sync jcode's TUI colors from pywal into ~/.jcode/config.toml.

jcode reads its colors from the [display.colors] table in
~/.jcode/config.toml, keyed by ~22 semantic "roles" (user, ai, accent,
error, ...).  There is no built-in pywal integration, so this script is
the bridge: every time pywal regenerates ~/.cache/wal/colors.json (i.e.
on every `wal -i <wallpaper>` / theme switch), run this so jcode follows
your pywal palette.

Only the roles listed below are overridden; every other role stays at
jcode's default, so a partial map stays coherent.  jcode hot-reloads
config.toml on change (it already does this for keybindings), so a
running instance picks the new colors up; use the in-TUI `/colors`
command or `/reload` to force an immediate repaint.

Usage:
    pywal-to-jcode.py            # sync from ~/.cache/wal/colors.json
    pywal-to-jcode.py --check    # print the role->hex table without writing
"""

import json
import sys
from pathlib import Path

WAL_PATH = Path.home() / ".cache" / "wal" / "colors.json"
JCODE_CONFIG = Path.home() / ".jcode" / "config.toml"


def load_palette():
    """Return (colors, special) dicts from pywal's colors.json."""
    with WAL_PATH.open() as f:
        data = json.load(f)
    colors = data.get("colors", {})
    special = data.get("special", {})
    return colors, special


def _rgb(hexcolor):
    h = hexcolor.lstrip("#")
    return tuple(int(h[i:i + 2], 16) for i in (0, 2, 4))


def _lux(hexcolor):
    """Relative luminance 0..1 (Rec. 709), for readability checks."""
    r, g, b = (c / 255.0 for c in _rgb(hexcolor))
    return 0.2126 * r + 0.7152 * g + 0.0722 * b


def _mix(a, b, t):
    """Linear-mix hex A toward hex B by amount T (0..1)."""
    aa, bb = _rgb(a), _rgb(b)
    return "#%02x%02x%02x" % tuple(
        round(x * (1 - t) + y * t) for x, y in zip(aa, bb)
    )


def build_role_map(colors, special):
    """Map pywal ANSI + special colors onto jcode's semantic roles.

    The mapping enforces readability the way a dark "black metal" theme
    expects: backgrounds stay black/dark, anything that reads as text is
    lifted to a light, high-contrast color, and the status roles are kept
    readable and separated by lightness (success pale, warning mid,
    error distinct) even when the source palette is desaturated.

    ANSI slots (pywal color0..15):
      0 black   1 red    2 green  3 yellow  4 blue    5 magenta
      6 cyan    7 white  8 brblack  9 brred 10 brgreen 11 bryellow ...
    """

    def pick(idx, fallback):
        return colors.get(f"color{idx}", fallback)

    def lighten(hexcolor, floor):
        """Lift HEXCOLOR toward the light foreground until it clears FLOOR."""
        if _lux(hexcolor) >= floor:
            return hexcolor
        return _mix(hexcolor, fg, (floor - _lux(hexcolor)) / max(1e-6, 1 - _lux(hexcolor)))

    fg = special.get("foreground", colors.get("color7", "#cccccc"))
    bg = special.get("background", colors.get("color0", "#000000"))
    # Light, reader-friendly text; the primary actors share the palette
    # foreground, the secondary/ai actor is a slightly cooler tint.
    user = lighten(fg, 0.72)
    ai = lighten(pick(6, fg), 0.66)
    # Brand accent: lift the blue-ish slot so it isn't a murky mid-gray.
    accent = lighten(pick(4, pick(12, fg)), 0.55)
    # Status hues stay conventional, each lifted to a readable floor and
    # offset in lightness so they never collapse into one gray.
    error = lighten(pick(1, pick(9, "#ff6464")), 0.50)
    warning = lighten(pick(3, pick(11, "#e5c07b")), 0.58)
    success = lighten(pick(2, pick(10, "#98c379")), 0.66)
    # Semi-muted but still legible secondary text.
    dim = lighten(pick(8, "#999999"), 0.44)
    # Chrome: a subtle dark line that stays visible against black.
    border = lighten(pick(8, "#333333"), 0.24)
    # Selection is a background slot: a near-black derived from the theme
    # background (bgs stay black), lifted just enough to read against it.
    selection_bg = _mix(bg, lighten(bg, 0.6), 0.30)

    return {
        # Chat actors (light text)
        "user": user,
        "ai": ai,
        "user_text": user,
        "ai_text": ai,
        # Brand/emphasis
        "accent": accent,
        # Status semantics (kept conventional, readability-floored)
        "error": error,
        "warning": warning,
        "success": success,
        # Muted / low-emphasis text
        "dim": dim,
        # Message/system states
        "system": ai,
        "queued": dim,
        "pending": warning,
        # Header chrome
        "header_icon": accent,
        "header_name": user,
        # Frame chrome (dark-against-black, not bright)
        "border": border,
        "selection_bg": selection_bg,
    }


def render_table(role_map):
    return ["[display.colors]"] + [f'{k} = "{v}"' for k, v in role_map.items()]


def write_config(role_map):
    """Replace only the [display.colors] section, preserving the rest."""
    lines = JCODE_CONFIG.read_text().splitlines()
    start = None
    for i, line in enumerate(lines):
        if line.strip() == "[display.colors]":
            start = i
            break
    block = render_table(role_map)
    if start is None:
        # No section yet: append at the end.
        text = JCODE_CONFIG.read_text().rstrip("\n")
        text += "\n" + "\n".join(block) + "\n"
        JCODE_CONFIG.write_text(text)
        return
    # Find the end: the next top-level (column 0) [section] header.
    end = start + 1
    while end < len(lines):
        s = lines[end]
        if s.startswith("[") and s.endswith("]"):
            break
        end += 1
    new = lines[:start] + block + lines[end:]
    JCODE_CONFIG.write_text("\n".join(new) + "\n")


def main():
    colors, special = load_palette()
    role_map = build_role_map(colors, special)
    if "--check" in sys.argv:
        print("\n".join(render_table(role_map)))
        return 0
    write_config(role_map)
    print(f"jcode colors synced from {WAL_PATH.name} -> {JCODE_CONFIG}")
    return 0


if __name__ == "__main__":
    sys.exit(main())