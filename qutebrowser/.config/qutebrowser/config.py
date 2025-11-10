# pylint: disable=C0111
c = c  # noqa: F821 pylint: disable=E0602,C0103
config = config  # noqa: F821 pylint: disable=E0602,C0103

import json
import os

# Read colors from pywal's JSON cache (minimal version)
wal_cache = os.path.expanduser('~/.cache/wal/colors.json')
try:
    with open(wal_cache, 'r') as f:
        wal = json.load(f)
except:
    wal = {'special': {'background': '#000000', 'foreground': '#ffffff'}, 'colors': {}}

bg = wal['special']['background']
fg = wal['special']['foreground']
c0 = wal['colors'].get('color0', '#808080')
c2 = wal['colors'].get('color2', '#808080')
c6 = wal['colors'].get('color6', '#808080')
c7 = wal['colors'].get('color7', '#000000')
c8 = wal['colors'].get('color8', '#808080')
c10 = wal['colors'].get('color10', '#808080')
c12 = wal['colors'].get('color12', '#808080')
c13 = wal['colors'].get('color13', '#808080')
c14 = wal['colors'].get('color14', '#808080')

# Minimal color config
c.colors.statusbar.normal.bg = "#00000000"
c.colors.statusbar.command.bg = "#00000000"
c.colors.statusbar.command.fg = fg
c.colors.statusbar.normal.fg = c14
c.colors.statusbar.url.fg = c13

c.colors.tabs.even.bg = c0
c.colors.tabs.odd.bg = c0
c.colors.tabs.bar.bg = "#00000000"
c.colors.tabs.even.fg = c6
c.colors.tabs.odd.fg = c13
c.colors.tabs.selected.even.bg = c2
c.colors.tabs.selected.odd.bg = c2
c.colors.tabs.selected.even.fg = c7
c.colors.tabs.selected.odd.fg = c7

c.colors.completion.odd.bg = bg
c.colors.completion.even.bg = bg
c.colors.completion.fg = fg

c.colors.messages.info.bg = bg
c.colors.messages.info.fg = fg
c.colors.messages.error.bg = bg
c.colors.messages.error.fg = fg

c.colors.downloads.bar.bg = c0
c.colors.downloads.start.bg = c10
c.colors.downloads.stop.bg = c8

# Core settings
c.tabs.title.format = "{audio}{current_title}"
c.fonts.web.size.default = 14
c.completion.open_categories = ['searchengines', 'quickmarks', 'bookmarks', 'history', 'filesystem']

config.load_autoconfig()

# Search engines
c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    '!g': 'https://www.google.com/search?q={}',
    '!sx': 'https://searx.be/search?q={}',
    '!aw': 'https://wiki.archlinux.org/?search={}',
    '!apkg': 'https://archlinux.org/packages/?sort=&q={}&maintainer=&flagged=',
    '!gh': 'https://github.com/search?o=desc&q={}&s=stars',
    '!yt': 'https://www.youtube.com/results?search_query={}',
}

c.auto_save.session = True

# Keybindings
config.bind('=', 'cmd-set-text -s :open')
config.bind('h', 'history')
config.bind('cs', 'cmd-set-text -s :config-source')
config.bind('tH', 'config-cycle tabs.show multiple never')
config.bind('sH', 'config-cycle statusbar.show always never')
config.bind('T', 'hint links tab')
config.bind('sc', 'config-source')

# UI
c.tabs.padding = {'top': 0, 'bottom': 0, 'left': 1, 'right': 1}
c.tabs.indicator.width = 0
c.tabs.width = '1%'
c.downloads.remove_finished = 0

# Fonts
c.fonts.default_family = 'Iosevka'
c.fonts.default_size = '12pt'

# Homepage
c.url.default_page = 'about:blank'
c.url.start_pages = ['about:blank']

# Dark mode
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
c.colors.webpage.darkmode.policy.images = 'never'

# Blocking
c.content.blocking.enabled = True
config.set("content.webgl", False, "*")
config.set("content.canvas_reading", False)
config.set("content.geolocation", False)
