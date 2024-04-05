" check if already running
if exists("g:loaded_nvim_funs")
    finish
endif
let g:loaded_nvim_funs = 1


" no deps


command! -nargs=0 FetchFuns lua require("nvim-funs").fetch_funs()
