syntax on
set autoindent
set nocompatible              " be iMproved, required
set relativenumber
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
	Plugin 'VundleVim/Vundle.vim'
	Plugin 'christoomey/vim-tmux-navigator'
	Plugin 'takac/vim-hardtime'
call vundle#end()            " required

filetype plugin indent on    " required

set bs=2
set number
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4

let g:netrw_keepdir = 0
let g:netrw_winsize = 20
let g:netrw_banner = 0
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

inoremap jk <ESC>

nnoremap <leader>dd :Lexplore %:p:h<CR>
nnoremap <Leader>da :Lexplore<CR>

function! NetrwMapping()
	nmap <buffer> H u
	nmap <buffer> h -^
	nmap <buffer> l <CR>

	nmap <buffer> . gh
	nmap <buffer> P <C-w>z

	nmap <buffer> L <CR>:Lexplore<CR>
	nmap <buffer> <Leader>dd :Lexplore<CR>
endfunction

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

function! CompileAndDebugFASM()
  let l:filename = expand('%:p')
  let l:output_file = expand('%:r')

  let l:compile_command = 'fasm ' . shellescape(l:filename)
  let l:debug_command = 'gf2 ' . shellescape(l:output_file)
  let l:compile_result = system(l:compile_command)

  if v:shell_error
    echohl ErrorMsg
    echom 'Compilation failed: '
    echom l:compile_result
    echohl None
  else
    echom 'Compilation succeeded: ' . l:output_file
    execute '!'. l:debug_command
  endif
endfunction

function! InsertBreakpoint()
  normal! o
  normal! iint3
endfunction

nnoremap <leader>gf :call CompileAndDebugFASM()<CR>
nnoremap <leader>i3 :call InsertBreakpoint()<CR>
