# vim-related

A Vim plugin for switching between multiple related files.

## Demo
![screenshot](https://github.com/shenbin04/artifactory/raw/master/vim-related/demo.gif)

## Inspiration

I found myself constantly need to switch between related files quickly and easily, e.g. between python file and test file. We can use alternate file feature like [vim-projectionist](https://github.com/tpope/vim-projectionist) for switching between two kinds of files. But things get more complicated quickly and I need to switch between multiple related files instead of two, e.g. javascript file, test file, css file and snapshot file.

I didn't find a good solution so I started to script. It works well for me but maybe only for me.

So I started to think of a more general approach and here we are this little plugin. It's not perfect by design and is not going to cover all cases.

## Installation

Install using your favorite plugin manager.

For example install with [vim-plug](https://github.com/junegunn/vim-plug), please add

```vim
Plug 'shenbin04/vim-related'
```

to .vimrc and run

```vim
:PlugInstall
```

## Configuration

vim-related comes with **default configs**, and can be further customized using:
- **global configs** in vim
- **json configs** per dir

#### Configuration Format

The configuration format is as below:

```
{
  <name>: {
    filetypes: <filetype>[],
    mappings: {[<mapping>]: <pattern>[]}
  }
}
```

- `name` is name of the config and can be any meaningful string, e.g. `javascript`.
- `filetypes` are the whitelist of filetypes for which we can check the mapping pattern, e.g. if we define filetypes as `["python"]`, only python files will add the `mappings` and be checked to match the `pattern`s.
- `mappings` are the dict of `mapping` to list of `pattern`s. A `mapping` will be created to navigate to the file matches the first `pattern` in th list.
- `pattern` is a special string with `{}`s which are matched against current file and `{}` will be replaced by the sub matches in order when navigate.

For example we have default config for javascript as

```json
{
  "javascript": {
    "filetypes": [
      "javascript",
      "javascript.jsx",
      "snap",
      "css",
      "scss.css"
    ],
    "mappings": {
      "gj": [
        "{}/{}.js",
        "{}/{}.jsx"
      ],
      "gc": [
        "{}/{}.css",
        "{}/{}.scss"
      ],
      "gt": [
        "{}/{}.test.js",
        "{}/{}.test.jsx"
      ],
      "gs": [
        "{}/__snapshots__/{}.test.js.snap",
        "{}/__snapshots__/{}.test.jsx.snap"
      ]
    }
  }
}
```

#### Default Config

There are default configs for common use cases.

In case if you prefer to not use it, please disable it by adding:

```vim
let g:related_enable_default_configs = 0
```

#### Global Config

We can config global configs by adding:

```vim
let g:related_configs = <config_as_you_need>
```

#### Json Config

We can also add **`.related.json`** file in dir or project for more specific configuration.

## Contributions & Issues

Pull requests and issue reports are super welcome!
