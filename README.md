## Waterproof Dev environment

This is a meta-project providing a setup to build coq-waterproof against the Rocq master branch along with master branches of other tools.

Building is done using `make all`.

To use `coq-lsp` in vscode, one can then run

```
dune exec -- code coq-waterproof
```

from the root directory.

To execute tests against the Waterproof exercises, run
```
dune test
```
