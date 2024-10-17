function! neoformat#formatters#bazel#enabled() abort
    return ['buildifier']
endfunction

function! neoformat#formatters#bazel#buildifier() abort
    return {
        \ 'exe': 'buildifier',
        \ 'args': ['-lint fix', '-mode fix']
        \ }
endfunction

