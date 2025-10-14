" --------------------------
" Plugin Manager (Vundle)
" --------------------------
source ~/.vim/bundle/vundle_setting.vim

" --------------------------
" 基础映射
" --------------------------
let mapleader = ","
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" --------------------------
" 基础设置
" --------------------------
set nu                      " 显示行号
syntax enable               " 启用语法高亮
filetype plugin indent on   " 文件类型插件和自动缩进

set wrap                    " 自动换行
set hlsearch                " 高亮搜索词
set laststatus=2            " 总是显示状态栏
set cursorline              " 光标行高亮
set hidden                  " 允许隐藏未保存buffer，方便切换

" 自动进入当前文件目录（代替 autochdir，避免问题）
autocmd BufEnter * silent! lcd %:p:h

" --------------------------
" 缩进与制表符设置
" --------------------------
set tabstop=8
set softtabstop=4
set shiftwidth=4

" Kernel Style 设置
command! KernelStyle call SetKernelStyle()
function! SetKernelStyle()
    setlocal tabstop=8 shiftwidth=8 softtabstop=8 noexpandtab
    echo "Switched to Kernel Style"
endfunction
nnoremap <leader>ks :KernelStyle<CR>

" User Style 设置
command! UserStyle call SetUserStyle()
function! SetUserStyle()
    setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
    echo "Switched to User Style"
endfunction
nnoremap <leader>us :UserStyle<CR>

" vim visual下replace的操作
command! -range -nargs=1 RV call s:ReplaceVisual(<line1>, <line2>, <f-args>)

function! s:ReplaceVisual(start, end, replacement)
    let l:target = getreg('"')
    execute a:start . ',' . a:end . 's/' . escape(l:target, '/\') . '/' . escape(a:replacement, '/\') . '/g'
endfunction

" 显示空白符
set list
set listchars=tab:>\ ,trail:-

" Quickfix 窗口自动移动到底部
autocmd FileType qf wincmd J

" 使用<leader>p 多次粘贴复制的内容
nnoremap <leader>p "0p

" --------------------------
" 颜色与编码
" --------------------------
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set background=dark
set termguicolors              " 启用真彩色支持
" Vim 24-bit RGB color sequences for terminals
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" 颜色方案（注释可以切换）
" colorscheme gruvbox-material
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox

" --------------------------
" vim-airline 配置
" --------------------------
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
"let g:airline_theme = 'onedark'
let g:airline_theme = 'base16_gruvbox_dark_hard'
let g:airline#extensions#default#section_truncate_width = {'b':79,'x':60,'y':80,'z':45}
let g:airline#extensions#default#layout = [['a','b','c'],['x','y','z']]
let g:airline#extensions#tabline#enabled = 1

" --------------------------
" 标签页管理映射
" --------------------------
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>tt :tabnext<CR>
nnoremap <leader>tp :tabprevious<CR>
nnoremap <leader>tH :-tabmove<CR>
nnoremap <leader>tL :+tabmove<CR>
nnoremap <leader>ts :tabs<CR>
for i in range(1,9)
    execute 'nnoremap <leader>' . i . ' ' . i . 'gt'
endfor

" --------------------------
" NERDTree 配置
" --------------------------
let g:NERDTreeWinSize = 35
let g:NERDTreeWinPos = "left"
noremap <silent> <leader>nn :NERDTreeToggle<CR>
noremap <silent> <leader>nf :NERDTreeFind<CR>

" ==============================================================================
" leaderf
" ==============================================================================
"let g:Lf_WorkingDirectoryMode = 'Ac'
autocmd BufRead,BufNewFile * setlocal buflisted
noremap <silent> <leader>m :<C-U>Leaderf mru<CR>
noremap <silent> <leader>b :<C-U>Leaderf buffer<CR>
noremap <silent> <leader>ta :<C-U>Leaderf tag<CR>
"noremap <silent> <leader>f :<C-U>Leaderf file<CR>
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_StlColorscheme = 'gruvbox_default'
let g:Lf_ShowRelativePath = 0
let g:Lf_WorkingDirectoryMode = 'Ac'   " 让LeaderF根据buffer自动切换路径
" ==============================================================================
" buffer
" ==============================================================================
noremap <silent> <Tab> :bnext<CR>
noremap <silent> <S-Tab> :bprev<CR>

" ==============================================================================
" fzf
" ==============================================================================
nmap <C-p> :Files<CR>
" ==============================================================================
" vim-rainbow
" ==============================================================================
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

" ==============================================================================
" Tagbar
" ==============================================================================
nnoremap <silent> <leader>to :TagbarToggle<CR>
nnoremap <silent> <leader>wm :NERDTreeToggle<CR> :TagbarToggle<CR>
augroup tagbar_auto_update
    autocmd!
    autocmd BufWinEnter * if exists('t:tagbar_bufs') | call tagbar#autoopen(1) | endif
augroup END
" ==============================================================================================
" cscope
" ==============================================================================
" cscope自动找cscope.out文件,并且将当前目录expand到cscope.out中
" 这样cscope找的时候就是绝对路径
function! SetupCscope()
  " 查找当前目录或父目录中的 cscope.out
  let l:cscope_file = findfile("cscope.out", ".;")
  if !empty(l:cscope_file)
    " 清除所有旧数据库
    silent! cs reset

    " 只添加一份数据库
    execute 'cs add ' . fnameescape(fnamemodify(l:cscope_file, ':p'))
    echom "Loaded cscope database from: " . fnamemodify(l:cscope_file, ':p:h')
  endif
endfunction

autocmd VimEnter * call SetupCscope()

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
" 这里打开会造成卡顿,以后再研究
" ==============================================================================
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
"let g:cpp_posix_standard = 1
"let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1

let g:vim_markdown_folding_disabled = 1


" ==============================================================================
" gerrit
" ==============================================================================
" hal use 120 col
set colorcolumn=100,120

" ==============================================================================
" gutentags
" ==============================================================================
let g:gutentags_modules = ['ctags', 'cscope']
let g:gutentags_project_root = ['.git', '.hg', '.svn', '.repo']

" ==============================================================================
" ripgrep
" =============================================================================
set grepprg=rg\ --vimgrep
