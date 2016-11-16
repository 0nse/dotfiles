function Source(file)
  let s:path = '$HOME/.config/nvim/config/'
  execute 'source' s:path . a:file . '.vim'
endfunction

function SourcePlugin(plugin)
  let s:prependedPath = 'plugins/' . a:plugin
  call Source(s:prependedPath)
endfunction

call Source('general')
call Source('indent')
call Source('navigation')
call Source('search')
call Source('persistence')
call Source('split')
call Source('session')
call Source('linelength')
call Source('performance')
call Source('filetypes')
call Source('menu')
call Source('spell')
" Plugins
call SourcePlugin('vim-plug')
call SourcePlugin('deoplete')
call SourcePlugin('vim-css-color')
call SourcePlugin('neomake')
call SourcePlugin('ranger')
call SourcePlugin('vim-airline')
call SourcePlugin('onedark')
call SourcePlugin('fzf')
call SourcePlugin('vim-easy-align')
call SourcePlugin('promptline')
call SourcePlugin('vim-esearch')
call SourcePlugin('emmet-vim')
call SourcePlugin('latexsuite')
call SourcePlugin('undotree')
call SourcePlugin('quick-scope')
call SourcePlugin('javascript-libraries-syntax')
call SourcePlugin('vim-fugitive')
call SourcePlugin('gitv')
call SourcePlugin('vim-javascript')
