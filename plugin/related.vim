let g:related_configs_global = {}
if get(g:, 'related_enable_default_configs', 1)
  let g:related_configs_global = {
        \  'javascript': {
        \    'filetypes': ['javascript', 'javascript.jsx', 'snap', 'css', 'scss.css'],
        \    'mappings': {
        \      'gj': ['{}/{}.js', '{}/{}.jsx'],
        \      'gc': ['{}/{}.css', '{}/{}.scss'],
        \      'gt': ['{}/{}.test.js', '{}/{}.test.jsx'],
        \      'gs': ['{}/__snapshots__/{}.test.js.snap', '{}/__snapshots__/{}.test.jsx.snap']
        \    }
        \  },
        \  'python': {
        \    'filetypes': ['python'],
        \    'mappings': {
        \      'gj': ['{}/{}.py'],
        \      'gt': ['{}/{}_test.py'],
        \    },
        \  },
        \  'vimscript': {
        \    'filetypes': ['vim'],
        \    'mappings': {
        \      'ga': ['{}/autoload/{}.vim'],
        \      'gp': ['{}/plugin/{}.vim', '{}/ftplugin/{}.vim'],
        \      'gs': ['{}/syntax/{}.vim'],
        \      'gi': ['{}/indent/{}.vim'],
        \    },
        \  },
        \}
endif

call extend(g:related_configs_global, get(g:, 'related_configs', {}))

augroup related
  autocmd!
  autocmd BufNewFile,BufReadPost * call related#detect()
augroup END
