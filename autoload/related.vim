let s:related_config_files = {}

function! related#detect() abort
  if empty(&ft)
    return
  endif

  let s:related_configs = g:related_configs_global

  let file = findfile('.related.json', '.;')
  if !empty(file) && filereadable(file)
    let config = get(s:related_config_files, file)

    if empty(config)
      try
        let config = json_decode(readfile(file))
        let s:related_config_files[file] = config
      catch
        echohl ErrorMsg
        echom 'Invalid .related.json config.'
        echohl None
      endtry
    endif
    let s:related_configs = extend(copy(s:related_configs), config)
  endif

  let b:related_matches = []

  for [name, config] in items(s:related_configs)
    if index(config.filetypes, &ft) > -1
      for [mapping, patterns] in items(config.mappings)
        execute 'nnoremap <buffer> <silent> <nowait> ' . mapping . ' :call related#switch(' . string(name) . ', ' . string(mapping) . ')<CR>'

        for pattern in patterns
          let regex = substitute(pattern, '{}', '(.+)', 'g')
          let matches = matchlist(expand('%:p'), '\v' . regex . '$')
          if !empty(matches)
            call insert(b:related_matches, filter(matches[1:], '!empty(v:val)'))
          endif
        endfor
      endfor
    endif
  endfor
endfunction

function! related#switch(name, mapping) abort
  let patterns = s:related_configs[a:name]['mappings'][a:mapping]
  for pattern in patterns
    for matches in b:related_matches
      let file = pattern

      for m in matches
        let file = substitute(file, '{}', m, '')
      endfor

      if file != expand('%:p') && getftime(file) > 0
        execute 'edit ' . fnameescape(fnamemodify(file, ':.'))
        return
      endif
    endfor
  endfor

  echohl ErrorMsg
  echom 'No related file'
  echohl None
endfunction
