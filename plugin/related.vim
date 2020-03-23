let g:related_configs_global = {}
if get(g:, 'related_enable_default_configs', 1)
  let g:related_configs_global = {
        \  'javascript': {
        \    'filetypes': ['javascript', 'javascript.jsx', 'snap', 'css', 'scss.css'],
        \    'mappings': {
        \      'gj': ['{}/{}.js', '{}/{}.jsx'],
        \      'gc': ['{}/{}.css', '{}/{}.scss'],
        \      'gt': ['{}/{}.test.js', '{}/{}.test.jsx', '{}/__tests__/{}.test.js', '{}/__tests__/{}.test.jsx'],
        \      'gs': ['{}/__snapshots__/{}.test.js.snap', '{}/__snapshots__/{}.test.jsx.snap']
        \    }
        \  },
        \  'typescript': {
        \    'filetypes': ['typescript', 'typescriptreact', 'snap', 'css', 'scss.css'],
        \    'mappings': {
        \      'gj': ['{}/{}.ts', '{}/{}.tsx'],
        \      'gc': ['{}/{}.css', '{}/{}.scss'],
        \      'gt': ['{}/{}.test.ts', '{}/{}.test.tsx', '{}/__tests__/{}.test.ts', '{}/__tests__/{}.test.tsx'],
        \      'gs': ['{}/__snapshots__/{}.test.ts.snap', '{}/__snapshots__/{}.test.tsx.snap']
        \    }
        \  },
        \  'python': {
        \    'filetypes': ['python'],
        \    'mappings': {
        \      'gp': ['{}/{}.py'],
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
        \  'objc': {
        \    'filetypes': ['objc', 'objcpp'],
        \    'mappings': {
        \      'gh': ['{}/{}.h'],
        \      'gm': ['{}/{}.m'],
        \    },
        \  },
        \  'c': {
        \    'filetypes': ['c', 'cpp'],
        \    'mappings': {
        \      'gh': ['{}/{}.h'],
        \      'gc': ['{}/{}.c', '{}/{}.cpp'],
        \    },
        \  },
        \  'go': {
        \    'filetypes': ['go'],
        \    'mappings': {
        \      'gj': ['{}/{}.go'],
        \      'gt': ['{}/{}_test.go'],
        \    },
        \  },
        \}
endif

call extend(g:related_configs_global, get(g:, 'related_configs', {}))

augroup related
  autocmd!
  autocmd BufNewFile,BufReadPost * call related#detect()
augroup END
