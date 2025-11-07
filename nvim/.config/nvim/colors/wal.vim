" Wal colorscheme for Neovim
" Dynamically sourced from ~/.cache/wal/colors-wal.vim

highlight clear
if exists("syntax_on")
  syntax reset
endif

" Load wal colors
let wal_colors_path = expand("~/.cache/wal/colors-wal.vim")
if filereadable(wal_colors_path)
  execute "source " . wal_colors_path
else
  " Fallback if wal colors don't exist
  let background = "#201d19"
  let foreground = "#dddfe1"
  let color0  = "#201d19"
  let color1  = "#918C8F"
  let color2  = "#A19CA0"
  let color3  = "#ADAEB2"
  let color4  = "#D1AF9F"
  let color5  = "#B3BAC4"
  let color6  = "#BFC3C9"
  let color7  = "#dddfe1"
  let color8  = "#9a9c9d"
  let color9  = "#918C8F"
  let color10 = "#A19CA0"
  let color11 = "#ADAEB2"
  let color12 = "#D1AF9F"
  let color13 = "#B3BAC4"
  let color14 = "#BFC3C9"
  let color15 = "#dddfe1"
endif

set background=dark
let g:colors_name = "wal"

" Set terminal colors to match wal palette
let g:terminal_color_0 = color0
let g:terminal_color_1 = color1
let g:terminal_color_2 = color2
let g:terminal_color_3 = color3
let g:terminal_color_4 = color4
let g:terminal_color_5 = color5
let g:terminal_color_6 = color6
let g:terminal_color_7 = color7
let g:terminal_color_8 = color8
let g:terminal_color_9 = color9
let g:terminal_color_10 = color10
let g:terminal_color_11 = color11
let g:terminal_color_12 = color12
let g:terminal_color_13 = color13
let g:terminal_color_14 = color14
let g:terminal_color_15 = color15

" UI Elements
execute "highlight Normal ctermfg=7 ctermbg=0 guifg=" . foreground . " guibg=" . background
execute "highlight NormalFloat ctermfg=7 ctermbg=0 guifg=" . foreground . " guibg=" . background
execute "highlight NonText ctermfg=8 ctermbg=NONE guifg=" . color8 . " guibg=NONE"
execute "highlight LineNr ctermfg=8 ctermbg=NONE guifg=" . color8 . " guibg=NONE"
execute "highlight CursorLineNr ctermfg=7 ctermbg=NONE guifg=" . color7 . " guibg=NONE"
execute "highlight CursorLine ctermbg=NONE guibg=NONE"
execute "highlight CursorColumn ctermbg=NONE guibg=NONE"

" Syntax highlighting
execute "highlight Statement ctermfg=1 guifg=" . color1
execute "highlight Keyword ctermfg=1 guifg=" . color1
execute "highlight Function ctermfg=4 guifg=" . color4
execute "highlight String ctermfg=2 guifg=" . color2
execute "highlight Comment ctermfg=8 guifg=" . color8
execute "highlight Type ctermfg=3 guifg=" . color3
execute "highlight Identifier ctermfg=4 guifg=" . color4
execute "highlight Constant ctermfg=5 guifg=" . color5
execute "highlight Number ctermfg=5 guifg=" . color5
execute "highlight Special ctermfg=6 guifg=" . color6

" UI Selections and highlights
execute "highlight Visual ctermbg=8 guibg=" . color8
execute "highlight Search ctermbg=3 ctermfg=0 guibg=" . color3 . " guifg=" . color0
execute "highlight IncSearch ctermbg=3 ctermfg=0 guibg=" . color3 . " guifg=" . color0
execute "highlight Pmenu ctermfg=7 ctermbg=8 guifg=" . foreground . " guibg=" . color8
execute "highlight PmenuSel ctermfg=0 ctermbg=3 guifg=" . color0 . " guibg=" . color3
execute "highlight StatusLine ctermfg=7 ctermbg=8 guifg=" . foreground . " guibg=" . color8
execute "highlight StatusLineNC ctermfg=8 ctermbg=NONE guifg=" . color8 . " guibg=NONE"

" Diagnostics
execute "highlight DiagnosticError ctermfg=1 guifg=" . color1
execute "highlight DiagnosticWarn ctermfg=3 guifg=" . color3
execute "highlight DiagnosticInfo ctermfg=4 guifg=" . color4
execute "highlight DiagnosticHint ctermfg=6 guifg=" . color6

" Diffs
execute "highlight DiffAdd ctermbg=2 guibg=" . color2
execute "highlight DiffDelete ctermbg=1 guibg=" . color1
execute "highlight DiffChange ctermbg=3 guibg=" . color3
execute "highlight DiffText ctermbg=5 guibg=" . color5

" vim-notify highlights
execute "highlight NotifyERRORBorder guifg=" . color1
execute "highlight NotifyERRORIcon guifg=" . color1
execute "highlight NotifyERRORTitle guifg=" . color1
execute "highlight NotifyWARNBorder guifg=" . color3
execute "highlight NotifyWARNIcon guifg=" . color3
execute "highlight NotifyWARNTitle guifg=" . color3
execute "highlight NotifyINFOBorder guifg=" . color4
execute "highlight NotifyINFOIcon guifg=" . color4
execute "highlight NotifyINFOTitle guifg=" . color4
execute "highlight NotifyDEBUGBorder guifg=" . color8
execute "highlight NotifyDEBUGIcon guifg=" . color8
execute "highlight NotifyDEBUGTitle guifg=" . color8
execute "highlight NotifyTRACEBorder guifg=" . color6
execute "highlight NotifyTRACEIcon guifg=" . color6
execute "highlight NotifyTRACETitle guifg=" . color6

" Snacks picker and dashboard
execute "highlight SnacksDashboardHeader guifg=" . color4
execute "highlight SnacksDashboardFooter guifg=" . color8
execute "highlight SnacksDashboardTitle guifg=" . color4 . " gui=bold"
execute "highlight SnacksDashboardDesc guifg=" . color7
execute "highlight SnacksDashboardIcon guifg=" . color4
execute "highlight SnacksDashboardKey guifg=" . color3

" Snacks picker highlights
execute "highlight SnacksPickerBorder guifg=" . color6
execute "highlight SnacksPickerTitle guifg=" . color4
execute "highlight SnacksPickerInput guifg=" . foreground . " guibg=" . background
execute "highlight SnacksPickerDir guifg=" . color4
execute "highlight SnacksPickerFile guifg=" . color7
execute "highlight SnacksPickerMatch guifg=" . color3 . " gui=bold"
execute "highlight SnacksPickerCurrent guifg=" . foreground . " guibg=" . color8

" Snacks picker file states (modified, staged, etc)
execute "highlight SnacksPickerModified guifg=" . color3
execute "highlight SnacksPickerStaged guifg=" . color2
execute "highlight SnacksPickerUntracked guifg=" . color8
execute "highlight SnacksPickerDeleted guifg=" . color1
execute "highlight SnacksPickerIgnored guifg=" . color8

" Snacks explorer file icons and states
execute "highlight SnacksExplorerNormal guifg=" . foreground . " guibg=" . background
execute "highlight SnacksExplorerDir guifg=" . color6
execute "highlight SnacksExplorerFile guifg=" . color7
execute "highlight SnacksExplorerIcon guifg=" . color6
execute "highlight SnacksExplorerFolder guifg=" . color6
execute "highlight SnacksExplorerFolderIcon guifg=" . color6
execute "highlight SnacksExplorerModified guifg=" . color3
execute "highlight SnacksExplorerStaged guifg=" . color2
execute "highlight SnacksExplorerUntracked guifg=" . color8
execute "highlight SnacksExplorerDeleted guifg=" . color1
execute "highlight SnacksExplorerIgnored guifg=" . color8
execute "highlight SnacksExplorerCursorLine guibg=" . color8 . " guifg=" . foreground
execute "highlight SnacksExplorerSearch guifg=" . color3 . " gui=bold"

" Generic folder/directory highlights (used by many plugins)
execute "highlight Directory guifg=" . color6
execute "highlight Folder guifg=" . color6
execute "highlight FolderOpen guifg=" . color6

" Snacks input/select
execute "highlight SnacksInputBorder guifg=" . color6
execute "highlight SnacksInputTitle guifg=" . color4
execute "highlight SnacksSelectBorder guifg=" . color6
execute "highlight SnacksSelectTitle guifg=" . color4

" Snacks terminal
execute "highlight SnacksTerminalBorder guifg=" . color6
execute "highlight SnacksTerminalTitle guifg=" . color4

" Snacks notifier
execute "highlight SnacksNotifierError guibg=" . color1
execute "highlight SnacksNotifierWarn guibg=" . color3
execute "highlight SnacksNotifierInfo guibg=" . color4
execute "highlight SnacksNotifierDebug guibg=" . color8

" Telescope
execute "highlight TelescopeBorder guifg=" . color6
execute "highlight TelescopeTitle guifg=" . color4
execute "highlight TelescopePromptBorder guifg=" . color6
execute "highlight TelescopePromptNormal guifg=" . foreground
execute "highlight TelescopeResultsTitle guifg=" . color4
execute "highlight TelescopePreviewTitle guifg=" . color4
execute "highlight TelescopeSelection guibg=" . color8 . " guifg=" . foreground
execute "highlight TelescopeMatching guifg=" . color3

" Fuzzy finder / picker common
execute "highlight FloatBorder guifg=" . color6 . " guibg=" . background
execute "highlight FloatTitle guifg=" . color4

" LSP/Completion
execute "highlight CmpDocBorder guifg=" . color6
execute "highlight CmpItemAbbrDeprecated guifg=" . color8 . " gui=strikethrough"
execute "highlight CmpItemAbbrMatch guifg=" . color3 . " gui=bold"
execute "highlight CmpItemAbbrMatchFuzzy guifg=" . color3 . " gui=bold"
execute "highlight CmpItemKindFunction guifg=" . color4
execute "highlight CmpItemKindVariable guifg=" . color5
execute "highlight CmpItemKindKeyword guifg=" . color1
execute "highlight CmpItemKindClass guifg=" . color4
execute "highlight CmpItemKindModule guifg=" . color6
execute "highlight CmpItemKindStruct guifg=" . color4
execute "highlight CmpItemKindEnum guifg=" . color3
execute "highlight CmpItemKindSnippet guifg=" . color2

" Folds and visual elements
execute "highlight Folded guifg=" . color8 . " guibg=" . background
execute "highlight FoldColumn guifg=" . color8 . " guibg=" . background
execute "highlight SignColumn guifg=" . color8 . " guibg=" . background
execute "highlight VertSplit guifg=" . color8
execute "highlight WinSeparator guifg=" . color8

" Diffview
execute "highlight DiffviewNormal guifg=" . foreground . " guibg=" . background
execute "highlight DiffviewCursorLine guibg=" . color8
execute "highlight DiffviewPrimary guifg=" . color4
execute "highlight DiffviewSecondary guifg=" . color6

" LSP signature help
execute "highlight LspSignatureActiveParameter guibg=" . color8 . " gui=bold"

" Breadcrumb
execute "highlight Breadcrumb guifg=" . color8

" Tree-like structures (nvim-tree, neo-tree, etc)
execute "highlight NvimTreeNormal guifg=" . foreground . " guibg=" . background
execute "highlight NvimTreeEndOfBuffer guifg=" . background . " guibg=" . background
execute "highlight NvimTreeCursorLine guibg=" . color8
execute "highlight NvimTreeExecFile guifg=" . color2 . " gui=bold"
execute "highlight NvimTreeGitNew guifg=" . color2
execute "highlight NvimTreeGitModified guifg=" . color3
execute "highlight NvimTreeGitDeleted guifg=" . color1
execute "highlight NvimTreeIndentMarker guifg=" . color8

