" ///////////////////////////////////////////////////////////////
" vundle: manage different plugins of Vim
" ///////////////////////////////////////////////////////////////

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=D:/program_files/Vim/vimfiles/bundle/Vundle.vim/
call vundle#begin('D:/program_files/Vim/vimfiles/bundle/')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'

Plugin 'vim-airline/vim-airline.git'
Plugin 'scrooloose/nerdtree.git'
Plugin 'vim-latex/vim-latex.git'
Plugin 'majutsushi/tagbar.git'
" Plugin 'Valloric/YouCompleteMe.git'


" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
Plugin 'minibufexpl.vim'
Plugin 'a.vim'

" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
"Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
filetype indent on
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" ///////////////////////////////////////////////////////////////
" settings for vim 
" ///////////////////////////////////////////////////////////////
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
" behave mswin

" set color scheme
color desert

" show line numbers
set nu

" spell check on
set spell

" switch off automatic creation of backup files
set nobackup
set nowritebackup
set swapfile
set dir=E:\temp
set encoding=utf-8
"set fileencodings=ucs-bom,utf-8,cp936
set fileencodings=utf-8,chinese,latin-1 
if has("win32")
set fileencoding=chinese
else
set fileencoding=utf-8
endif
"解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"解决consle输出乱码
language messages zh_CN.utf-8

set fileencoding=gb2312
"set termencoding=utf-8

filetype indent on

"////↑////↑////↑////↑////↑//// settings for vim  ////↑////↑////↑////↑////


" ///////////////////////////////////////////////////////////////
" minibuffer explorer 
" ///////////////////////////////////////////////////////////////

" avoiding more than one minibufexplorer exists
let g:miniBufExplorerMoreThanOne=0

"////↑////↑////↑////↑//// minibuffer explorer ////↑////↑////↑////↑////




" //////////////////////////////////////////////////////////////////////
" vim-latex-suit  
" /////////////////////////////////////////////////////////////////////

" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
let g:Tex_ViewRule_pdf = 'C:\Program Files (x86)\Tools\Foxit Reader.exe'
let g:Tex_DefaultTargetFormat = 'pdf'

" turn off Python for avoiding errors
let g:Tex_UsePython = 1 

function CompileXeTex()
    let g:Tex_DefaultTargetFormat = 'pdf' 
    let oldCompileRule=g:Tex_CompileRule_pdf
    let g:Tex_CompileRule_pdf = 'xelatex --synctex=-1 -src-specials -interaction=nonstopmode $*'
    call Tex_RunLaTeX()
    let g:Tex_CompileRule_pdf=oldCompileRule
endfunction
map <Leader>lx :<C-U>call CompileXeTex()<CR>
map <F2> :bn<CR>
"////↑////↑////↑////↑//// vim-latex-suit ////↑////↑////↑////↑////


autocmd vimenter * NERDTree E:\research

"let g:syntastic_python_python_exec = 'python3'
"let g:ycm_global_ycm_extra_conf = 'D:\program_files\vim\vimfiles\bundle\YouCompleteMe\third_party\ycmd\.ycm_extra_conf.py' 

"let g:ycm_server_python_interpreter = 'D:\program_files\Python\Python36\python.exe'
"let g:ycm_python_binary_path = 'D:\program_files\Python\Python36\python.exe'

let g:ycm_server_use_vim_stdout = 0
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

let g:tagbar_ctags_bin = 'D:\program_files\single_bin\ctags.exe'
let g:tagbar_right = 1
"let g:tagbar_width = 60
let g:tagbar_systemenc = 'utf-8'
nmap <F8> :TagbarToggle<CR>

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
