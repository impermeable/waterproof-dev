## Waterproof Dev environment

This is a meta-project providing a setup to build coq-waterproof against the Rocq master branch along with master branches of other tools.

Building is done using `make all`.

coq-lsp is currently untested in this setup.

## Alternative instructions

To get the setup to work, one may need to execute
```
opam install ./coq-lsp.opam --deps-only
```
from the root directory.

From there, one should be able to just run
```
dune build
```
from the root directory.

To use `coq-lsp` in vscode, one can then run

```
dune exec -- code .
```

from the root directory.

To execute tests against the Waterproof exercises, run
```
dune test
```