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
      \   "AirlineTheme rigel",
      \   ]
let g:colorSchemeList['Dracula'] = [
      \   'set termguicolors',
      \   'colorscheme dracula',
      \   'set background=dark',
      \   "let g:dracula_italic=1",
      \   "let g:dracula=1",
      \   "AirlineTheme dracula",
      \   ]
let g:colorSchemeList['Nord'] = [
      \   'colorscheme nord',
      \   "let g:nord_italic=1",
      \   "let g:nord_underline=1",
      \   "AirlineTheme nord",
      \   ]
let g:colorSchemeList['Gruvbox Dark'] = [
      \   'colorscheme gruvbox',
      \   'set background=dark',
      \   "let g:gruvbox_contrast_dark ='hard'",
      \   "let g:gruvbox_sign_column ='bg0'",
      \   "let g:gruvbox_invert_selection =0",
      \   "AirlineTheme gruvbox",
      \   ]
let g:colorSchemeList['Gruvbox Light'] = [
      \   'colorscheme gruvbox',
      \   'set background=light',
      \   "let g:gruvbox_contrast_light ='hard'",
      \   "let g:gruvbox_sign_column ='bg0'",
      \   "let g:gruvbox_invert_selection =0",
      \   "AirlineTheme gruvbox",
      \   ]
let g:colorSchemeList['PaperColor Light'] = [
      \   'colorscheme PaperColor',
      \   'set background=light',
      \   'AirlineTheme papercolor',
      \   ]
let g:colorSchemeList['Ayu Light'] = [
      \   'colorscheme ayu',
      \   'let ayucolor="light"',
      \   'set background=light',
      \   'AirlineTheme ayu',
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

