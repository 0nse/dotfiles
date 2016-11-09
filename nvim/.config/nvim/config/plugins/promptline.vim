let g:promptline_preset = {
      \'a'    : [ '\t' ],
      \'b'    : [ promptline#slices#git_status(), promptline#slices#vcs_branch() ],
      \'c'    : [ promptline#slices#cwd() ],
      \'warn' : [ promptline#slices#battery(), promptline#slices#last_exit_code() ]}

let g:promptline_theme =  {
        \'a'    : [00, 04],
        \'b'    : [08, 237],
        \'c'    : [08, 234],
        \'x'    : [188, 234],
        \'y'    : [231, 240],
        \'z'    : [233, 183],
        \'warn' : [00, 03]}
