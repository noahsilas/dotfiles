""" Hustle specific tricks
" Hustle keeps some compiled assets in a `dst` folder; ignore it when
" searching
set wildignore+=*/dst

" HustleInc/backend adds "src" to the node path, so to use `gf` to find
" some modules, I need it to also be in the vim path
set path+=src

" via https://vi.stackexchange.com/questions/29062/how-to-check-if-a-string-starts-with-another-string-in-vimscript
fu StartsWith(longer, shorter) abort
  return a:longer[0:len(a:shorter)-1] ==# a:shorter
endfunction

" HustleInc/webapps uses some tricky aliases when resolving files; Add some
" smarts so `gf` can follow them.
function HustleTransform(target)
  let helloWorld = '~/Hustle/hello-world/'

  " Actual path prefix is `@hustle/backend`, but the @ isn't in the `isfname`
  " option. Maybe I should add that? :thinking:
  if StartsWith(a:target, 'hustle/backend')
    let path = a:target[len('hustle/backend'):]
    return helloWorld . 'backend/src/' . path
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
