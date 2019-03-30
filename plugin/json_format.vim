if exists('g:loaded_json_format') || &cp
    finish
endif
let g:loaded_json_format = 1

function! json_format#parse(mode)
    let dictCmd = {"v":"'<,'>", "l":line("."), "n":"%"}
    
    silent execute ":"dictCmd[a:mode]"!python -c '
        \import json,sys;
        \reload(sys);
        \sys.setdefaultencoding(\"utf-8\");
        \js = json.loads(sys.stdin.read().strip());
        \print json.dumps(js, sort_keys=False, indent="shiftwidth()",
                         \ensure_ascii=False);
        \'"
endfunction

" Format Line Under Cursor
map <leader>js :call json_format#parse("l")<cr>
" Format Visual Selection
vmap <leader>js :call json_format#parse("v")<cr>
" Format Entire Buffer
nmap <leader>jsf :call json_format#parse("n")<cr>
