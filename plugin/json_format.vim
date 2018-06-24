if exists('g:loaded_json_format') || &cp
    finish
endif

let g:loaded_json_format = 1

function! json_format#parse(mode)
    let dictCmd = {"v":"'<,'>", "l":line("."), "n":"%"}
    silent execute ":"dictCmd[a:mode]"!python -c 'import json,sys;reload(sys);sys.setdefaultencoding(\"utf-8\");js = json.loads(sys.stdin.read().strip());print json.dumps(js, sort_keys=False, indent=4, ensure_ascii=False);'"
endfunction

map <leader>js :call json_format#parse("l")<cr>
vmap <leader>js :call json_format#parse("v")<cr>
nmap <leader>jsf :call json_format#parse("n")<cr>
