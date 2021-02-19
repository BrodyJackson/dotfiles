colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_sign_column = "bg0"
let g:gruvbox_invert_selection =0
let g:airline_theme = "gruvbox"

let g:colorSchemeList = {}
let g:colorSchemeList['Rigel'] = [
      \   'set termguicolors',
      \   'colorscheme rigel',
      \   'set background=dark',
      \   "let g:rigel_italic=1",
      \   "let g:rigel_bold=1",
      \   ]
let g:colorSchemeList['Dracula'] = [
      \   'set termguicolors',
      \   'colorscheme dracula',
      \   'set background=dark',
      \   "let g:dracula_italic=1",
      \   "let g:dracula=1",
      \   "let g:airline_theme='dracula'",
      \   ]
let g:colorSchemeList['Nord'] = [
      \   'colorscheme nord',
      \   "let g:nord_italic=1",
      \   "let g:nord_underline=1",
      \   "let g:airline_theme='nord'",
      \   ]
let g:colorSchemeList['Gruvbox Dark'] = [
      \   'colorscheme gruvbox',
      \   'set background=dark',
      \   "let g:gruvbox_contrast_dark ='hard'",
      \   "let g:gruvbox_sign_column ='bg0'",
      \   "let g:gruvbox_invert_selection =0",
      \   "let g:airline_theme='gruvbox'",
      \   ]
let g:colorSchemeList['Gruvbox Light'] = [
      \   'colorscheme gruvbox',
      \   'set background=light',
      \   "let g:gruvbox_contrast_light ='hard'",
      \   "let g:gruvbox_sign_column ='bg0'",
      \   "let g:gruvbox_invert_selection =0",
      \   "let g:airline_theme='gruvbox'",
      \   ]

function SwitchColorScheme(name)
  for l:item in g:colorSchemeList[a:name]
    execute l:item
  endfor
endfunction

function! s:Color(a, l, p)
  return keys(g:colorSchemeList)
endfunction

command! -bar -nargs=? -complete=customlist,<sid>Color SwitchColors call SwitchColorScheme(<f-args>)

