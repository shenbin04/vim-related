function! related#detect()
  if empty(&ft)
    return
  endif

  let g:related_configs = {}
  if get(g:, 'related_enable_default_configs', 1)
    let g:related_configs = {
          \  'jsx': {
          \    'filetypes': ['javascript', 'javascript.jsx', 'snap', 'css', 'scss.css'],
          \    'mappings': {
          \      'gj': ['{}/{}.js', '{}/{}.jsx'],
          \      'gc': ['{}/{}.css', '{}/{}.scss'],
          \      'gt': ['{}/{}.test.js', '{}/{}.test.jsx'],
          \      'gs': ['{}/__snapshots__/{}.test.js.snap', '{}/__snapshots__/{}.test.jsx.snap']
          \    }
          \  },
          \  'vimscript': {
          \    'filetypes': ['vim'],
          \    'mappings': {
          \      'ga': ['{}/autoload/{}.vim'],
          \      'gs': ['{}/plugin/{}.vim', '{}/ftpplugin/{}.vim'],
          \    },
          \  },
          \}
  endif

  let file = findfile('.related.json', '.;')
  if !empty(file) && filereadable(file)
    try
      let value = projectionist#json_parse(readfile(file))
      call extend(g:related_configs, value)
    catch /^invalid JSON:/
      return
    endtry
  endif

  let b:related_matches = []

  for [name, config] in items(g:related_configs)
    if index(config.filetypes, &ft) > -1
      for [mapping, patterns] in items(config.mappings)
        execute 'nnoremap <buffer> <silent> <nowait> ' . mapping . ' :call related#switch(' . string(name) . ', ' . string(mapping) . ')<CR>'

        if !empty(b:related_matches)
          continue
        endif

        for pattern in patterns
          let regex = substitute(pattern, '{}', '(.+)', 'g')
          let matches = matchlist(expand('%:p'), '\v' . regex)
          if !empty(matches)
            let b:related_matches = filter(matches[1:], '!empty(v:val)')
          endif
        endfor
      endfor
    endif
  endfor
endfunction

function! related#switch(name, mapping)
  let patterns = g:related_configs[a:name]['mappings'][a:mapping]
  for pattern in patterns
    let file = pattern
    for m in b:related_matches
      let file = substitute(file, '{}', m, '')
    endfor
    if getftime(file) > 0
      execute 'edit ' . fnameescape(fnamemodify(file, ':.'))
      return
    endif
  endfor

  echohl ErrorMsg
  echom 'No related file'
  echohl None
endfunction

