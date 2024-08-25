"vundle-setting.vim
source ~/.vim/bundle/vundle_setting.vim

" ==============================================================================
" basic set
" ==============================================================================
set nu
syntax enable
filetype on
"set nowrap	      " 不要自动换行
set wrap	      " 自动换行
set hlsearch	      " 选中的词高亮
set laststatus=2      " 永远显示状态栏
set cursorline	      " 设置光标行高亮
set autochdir
set tabstop=8  	      "Tab 8 blanks
set softtabstop=4
set shiftwidth=4

if &filetype == 'python'
	set expandtab
else
	set noexpandtab
endif
" set listchar
set listchars=tab:>\ ,trail:-
" set listchars=tab:>\ ,trail:-, space:·
set list

" ==============================================================================
" color and fonts
" ==============================================================================
set t_Co=256          " 强制使用 256 色
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
colorscheme gruvbox
set background=dark
set termguicolors     " 使用真彩色 (如果使用 24 位色彩)
" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" ==============================================================================
" basic map
" ==============================================================================
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l
let mapleader = ","

" ==============================================================================
" vim-airline
" ==============================================================================
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
"let g:airline_theme='onedark'
let g:airline_theme='desertink'
let g:airline#extensions#default#section_truncate_width = {
   \ 'b': 79,
   \ 'x': 60,
   \ 'y': 80,
   \ 'z': 45,
   \ }
let g:airline#extensions#default#layout = [
    \ [ 'a', 'b', 'c' ],
    \ [ 'x', 'y', 'z' ]
    \ ]

" ==============================================================================
" NERDTree
" ==============================================================================
let g:NERDTreeWinSize = 40
let g:NERDTreeWinPos = "left"
noremap <silent> <leader>nn :NERDTreeToggle<CR>
noremap <silent> <leader>nf :NERDTreeFind<CR>

" ==============================================================================
" leaderf
" ==============================================================================
let g:Lf_WorkingDirectoryMode = 'Ac'
noremap <silent> <leader>m :<C-U>Leaderf mru<CR>
noremap <silent> <leader>b :<C-U>Leaderf buffer<CR>
noremap <silent> <leader>t :<C-U>Leaderf tag<CR>
noremap <silent> <leader>f :<C-U>Leaderf file<CR>
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_StlColorscheme = 'gruvbox_default'
let g:Lf_ShowRelativePath = 0

" ==============================================================================
" vim-rainbow
" ==============================================================================
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

" ==============================================================================
" taglist
" ==============================================================================
nnoremap <silent> <F8> :TlistToggle<CR>
let Tlist_Use_Right_Window = 1
let Tlist_WinWidth = 40
let Tlist_Show_One_File = 1				"Tlist只显示一个文件

nnoremap <silent> <leader>wm :NERDTreeToggle<CR> :TlistToggle<CR>

" ==============================================================================
" cscope
" ==============================================================================
if has("cscope")
   set csprg=/usr/bin/cscope              "指定用来执行 cscope 的命令
   set csto=1                             "先搜索tags标签文件，再搜索cscope数据库
   set cst                                "使用|:cstag|(:cs find g)，而不是缺省的:tag
   set nocsverb                           "不显示添加数据库是否成功
   " add any database in current directory
   if filereadable("cscope.out")
	execute 'cs add ' . expand('%:p:h') . '/cscope.out'
   endif
   set csverb                             "显示添加成功与否
endif

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" ==============================================================================
" cpp enhanced highlight
" ==============================================================================
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1
