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
  let replacements = {
    \ '~admin': helloWorld . 'webapps/src/admin/js',
    \ '~agent': helloWorld . 'webapps/src/agent/js',
    \ '~component-library': helloWorld . 'webapps/src/component-library',
    \ '~shared': helloWorld . 'webapps/src/shared',
    \ '~hustlejs': helloWorld . 'webapps/src/hustlejs',
    \ '~/': helloWorld . 'command-center/src/js/'
    \ }
  let values = split(a:target, '\/')
  let initial = values[0]
  let rest = join(values[1:], '/')
  let replacement = get(replacements, initial, initial)
  return replacement . '/' . rest
endfunction

set includeexpr=HustleTransform(v:fname)
