" Yeah, yeah, I know.
source $VIMRUNTIME/mswin.vim

set nobackup
set nowritebackup
set nocompatible

scriptencoding utf-8
set encoding=utf-8

" Formatting
set tabstop=4
set nowrap

" Pretty colors
syntax on
colorscheme molokai

" Visible whitespace
set listchars=trail:·,precedes:«,extends:»,tab:·\ 
set list

" Gvim specific
set guifont=Consolas:h11
set guioptions-=T

" Show line numbers in gutter
set number

" Status line
set laststatus=2 " always show status line

if has('statusline')
	" Status line detail:
	" %f     file path
	" %y     file type between braces (if defined)
	" %([%R%M]%)   read-only, modified and modifiable flags between braces
	" %{'!'[&ff=='default_file_format']}
	"        shows a '!' if the file format is not the platform
	"        default
	" %{'$'[!&list]}  shows a '*' if in list mode
	" %{'~'[&pm=='']} shows a '~' if in patchmode
	" (%{synIDattr(synID(line('.'),col('.'),0),'name')})
	"        only for debug : display the current syntax item name
	" %=     right-align following items
	" #%n    buffer number
	" %l/%L,%c%V   line number, total number of lines, and column number
	function SetStatusLineStyle()
		if &stl == '' || &stl =~ 'synID'
			let &stl="%f %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]}%{'~'[&pm=='']}%=#%n   line %l/%L, col %v "
		else
			let &stl="%f %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]} (%{synIDattr(synID(line('.'),col('.'),0),'name')})%=#%n   line %l/%L, col %v "
		endif
	endfunc
	" Switch between the normal and vim-debug modes in the status line
	nmap _ds :call SetStatusLineStyle()<CR>
	call SetStatusLineStyle()
	" Window title
	if has('title')
		set titlestring=%t%(\ [%R%M]%)
	endif
endif
