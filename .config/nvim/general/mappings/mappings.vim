"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Splits and tabbed files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic Key Mappings

" Remap splits navigation to just CTRL + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" g Leader key
let mapleader=" "
" let localleader=" "
nnoremap <Space> <Nop>

" Make adjusing split sizes a bit more friendly 
" (These are really wierd because of alt key on mac)
nnoremap <silent> ∆    :resize -2<CR>
nnoremap <silent> ˚    :resize +2<CR>
nnoremap <silent> ˙    :vertical resize -2<CR>
nnoremap <silent> ¬    :vertical resize +2<CR>

" Change 2 split windows from vert to horiz or horiz to vert
map <Leader>th <C-w>t<C-w>H
map <Leader>tk <C-w>t<C-w>K

" Removes pipes | that act as seperators on splits
set fillchars+=vert:\ 

" Better indenting (Remembers selection for multiple tabbing)
vnoremap < <gv
vnoremap > >gv

" TAB in general mode will move to text buffer
nnoremap <silent> <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <silent> <S-TAB> :bprevious<CR>

" <TAB>: completion.
inoremap <silent> <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

map <C-D-f> :Ag<CR>

if has("mac") || has("gui_macvim") || has("gui_mac")
  " relative path  (src/foo.txt)
  nnoremap <leader>cf :let @*=expand("%")<CR>
endif

if has("gui_gtk") || has("gui_gtk2") || has("gui_gnome") || has("unix")
  " relative path (src/foo.txt)
  nnoremap <leader>cf :let @+=expand("%")<CR>
endif
