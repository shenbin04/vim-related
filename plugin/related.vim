augroup related
  autocmd!
  autocmd BufNewFile,BufReadPost * call related#detect()
augroup END
