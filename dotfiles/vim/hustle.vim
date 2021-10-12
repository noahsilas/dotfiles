""" Hustle specific tricks
" Hustle keeps some compiled assets in a `dst` folder; ignore it when
" searching
set wildignore+=*/dst

" HustleInc/backend adds "src" to the node path, so to use `gf` to find
" some modules, I need it to also be in the vim path
set path+=src

" HustleInc/webapps uses some tricky aliases when resolving files; Add some
" smarts so `gf` can follow them.
function HustleTransform(target)
  let helloWorld = '~/Hustle/hello-world/'

  " Backend uses '~' alone as the prefix. If this buffer is a backend buffer,
  " directly replace a leading tilde with the backend src path.
  let filePath = expand('%:p')
  let inBackend = stridx(filePath, 'backend') != -1
  if inBackend && a:target[0] == '~'
    return helloWorld . 'backend/src/' . a:target[1:]
  endif

  let replacements = {
    \ '~admin': helloWorld . 'webapps/src/admin/js',
    \ '~agent': helloWorld . 'webapps/src/agent/js',
    \ '~component-library': helloWorld . 'webapps/src/component-library',
    \ '~shared': helloWorld . 'webapps/src/shared',
    \ '~hustlejs': helloWorld . 'webapps/src/hustlejs',
    \ '~': helloWorld . 'command-center/src/js/',
    \ }
  let values = split(a:target, '\/')
  let initial = values[0]
  let rest = join(values[1:], '/')
  let replacement = get(replacements, initial, initial)
  return replacement . '/' . rest
endfunction

set includeexpr=HustleTransform(v:fname)

" Tape Autoloads files in some directories that include `.js` anywhere in
" their name, so we don't want our swapfiles to be in those directories.
au BufRead,BufNewFile,BufEnter /Users/noahsilas/Hustle/TapeServer/* setlocal backupdir=~/.vim/tmp// directory=~/.vim/tmp// undodir=~/.vim/tmp//
au BufRead,BufNewFile,BufEnter /Users/noahsilas/Hustle/TapeSite/* setlocal backupdir=~/.vim/tmp// directory=~/.vim/tmp// undodir=~/.vim/tmp//
