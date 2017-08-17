"===============================================================================
"                      ____  ____ ______ __  __   ___   __
"                     ||    ||    | || | ||  ||  // \\  ||
"                     ||==  ||==    ||   ||==|| ((   )) ||
"                     ||    ||___   ||   ||  ||  \\_//  ||
"
" URL: https://github.com/theJian/vim-fethoi
" Author: theJian <thejianmail@gmail.com>
" License: GPL
"===============================================================================

set background=dark
highlight clear
if (exists('syntax_on'))
	syntax reset
endif
let g:colors_name = 'fethoi'

" Utility functions ============================================================

function! s:Highlight(args)
	exec 'highlight ' . join(a:args, ' ')
endfunction

function! s:Clear(group)
	exec 'highlight clear ' . a:group
endfunction

function! s:AddGroundValues(accumulator, ground, color)
	let lst = a:accumulator
	for [where, value] in items(a:color)
		call add(lst, where . a:ground . '=' . value)
	endfor
	return lst
endfunction

function! s:h(group, fg, ...)
	" optional `bg`, `attr`
	let params = [a:group]

	if a:fg !=# ''
		let params = s:AddGroundValues(params, 'fg', s:colors[a:fg])
	endif
	
	if a:0 > 0 && a:1 !=# ''
		let params = s:AddGroundValues(params, 'bg', s:colors[a:1])
	endif

	if a:0 > 1 && a:2 !=# ''
		let params = params + ['term=' . a:2, 'cterm=' . a:2, 'gui=' . a:2]
	endif

	call s:Clear(a:group)
	call s:Highlight(params)
endfunction

" Colors =======================================================================

let s:colors = {}

let s:colors.base0  = { 'gui': '#0c1010', 'cterm': 0 }
let s:colors.base1 =  { 'gui': '#0a191a', 'cterm': 8 }
let s:colors.base2  = { 'gui': '#122e36', 'cterm': 10 }
let s:colors.base3  = { 'gui': '#0f5447', 'cterm': 12 }
let s:colors.base4 = { 'gui': '#1e7971', 'cterm': 11 }
let s:colors.base5 = { 'gui': '#5fb7b3', 'cterm': 14 }
let s:colors.base6 = { 'gui': '#c3f3e8', 'cterm': 7 }
let s:colors.base7 = { 'gui': '#d3efeb', 'cterm': 15 }
let s:colors.yellow  = { 'gui': '#b7a668', 'cterm': 3 }
let s:colors.orange  = { 'gui': '#bf6654', 'cterm': 9 }
let s:colors.red  = { 'gui': '#c71f43', 'cterm': 1 }
let s:colors.magenta  = { 'gui': '#90708c', 'cterm': 5 }
let s:colors.violet  = { 'gui': '#8984c3', 'cterm': 13 }
let s:colors.blue  = { 'gui': '#28858a', 'cterm': 4 }
let s:colors.cyan  = { 'gui': '#0ea5c5', 'cterm': 6 }
let s:colors.green  = { 'gui': '#5ac878', 'cterm': 2 }

" neovim terminal
let g:terminal_color_0  = get(s:colors.base0, 'gui')
let g:terminal_color_8  = g:terminal_color_0
let g:terminal_color_1  = get(s:colors.red, 'gui')
let g:terminal_color_9  = g:terminal_color_1
let g:terminal_color_2  = get(s:colors.green, 'gui')
let g:terminal_color_10 = g:terminal_color_2
let g:terminal_color_3  = get(s:colors.yellow, 'gui')
let g:terminal_color_11 = g:terminal_color_3
let g:terminal_color_4  = get(s:colors.blue, 'gui')
let g:terminal_color_12 = g:terminal_color_4
let g:terminal_color_5  = get(s:colors.violet, 'gui')
let g:terminal_color_13 = g:terminal_color_5
let g:terminal_color_6  = get(s:colors.cyan, 'gui')
let g:terminal_color_14 = g:terminal_color_6
let g:terminal_color_7  = get(s:colors.base6, 'gui')
let g:terminal_color_15 = g:terminal_color_7

" Highlight =====================================================================

let s:background = 'base0'
let s:linenr_background = 'base1'

" Syntax group
call s:h('Normal', 'base5', s:background)
call s:h('Comment', 'base4')
call s:h('Constant', 'cyan')
call s:h("String", 'green')
call s:h('Number', 'green')
call s:h('Identifier', 'magenta')
call s:h('Statement', 'blue')
call s:h('PreProc', 'violet')
call s:h('Type', 'orange')
call s:h('Special', 'orange')
call s:h('Tag', 'blue')
call s:h('Delimiter', 'orange')
call s:h('Underlined', 'yellow', '', 'underline')
call s:h('Error', 'red', 'base0')
call s:h('Todo', 'base5', 'base2', 'bold') " anything that needs extra attention; mostly the keywords TODO FIXME and XXX

" Directories
call s:h('Directory', 'blue')

" Diffing
call s:h('DiffAdd', 'base6', 'green')
call s:h('DiffChange', 'base6', 'blue')
call s:h('DiffDelete', 'base6', 'red')
call s:h('DiffText', 'base6', 'cyan')
call s:h('DiffAdded', 'green')
call s:h('DiffChanged', 'blue')
call s:h('DiffRemoved', 'red')
call s:h('DiffSubname', 'blue')

" Command line
call s:h('ErrorMsg', 'red')
call s:h('Error', 'red')
call s:h('ModeMsg', 'orange')
call s:h('WarningMsg', 'red')

" Cursor
call s:h('Cursor', 'base1', 'base6')
call s:h('CursorLine', '', 'base1')
call s:h('CursorColumn', '', 'base1')

" Sign column, line numbers
call s:h('LineNr', 'base3', s:linenr_background)
call s:h('CursorLineNr', 'blue', s:linenr_background)
call s:h('SignColumn', '', s:linenr_background)
call s:h('ColorColumn', '', s:linenr_background)

" Visual selection.
call s:h('Visual', '', 'base2')

" The column separating vertical splits
call s:h('VertSplit', 'blue', s:linenr_background)

" Status line
call s:h('StatusLine', 'base5', s:linenr_background)
call s:h('StatusLineNC', 'base4', s:background)

" Folds
call s:h('Folded', 'base4')
call s:h('FoldColumn', 'base4')

" Searching
call s:h('Search', 'base1', 'yellow')

" Match parenthesis
call s:h('MatchParen', 'base1', 'orange')

" Non text
call s:h('NonText', 'base2')

" Popup menu
call s:h('Pmenu', 'base6', 'base2')
call s:h('PmenuSel', 'base7', 'base4')
call s:h('PmenuSbar', '', 'base2')
call s:h('PmenuThumb', '', 'base6')

" Hit-enter prompt and yes/no questions
call s:h('Question', 'violet')

" Special keys
call s:h('SpecialKey', 'base3')

" Tab line.
call s:h('TabLineSel', 'base7', 'base4')
call s:h('TabLine', 'base6', 'base2')
call s:h('TabLineFill', s:background)

" Title
call s:h('Title', 'orange', '', 'bold')

" Wild menu
call s:h('WildMenu', 'base7', 'base4')

" Python
call s:h('pythonStatement', 'blue')

" JavaScript
call s:h('javaScriptFunction', 'blue')
call s:h('javaScriptBraces', 'blue')
call s:h('javaScriptParens', 'blue')
call s:h('javaScriptIdentifier', 'blue')
call s:h('javaScriptReserved', 'blue')

" Clean up =====================================================================

unlet s:colors
unlet s:background
unlet s:linenr_background
