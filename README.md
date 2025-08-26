## Waterproof Dev environment

This is a meta-project providing a setup to build coq-waterproof
against the Rocq master branch along with master branches of other
tools.

Building is done using `make`.

To use `coq-lsp` in vscode, one can then run

```
dune exec -- code coq-waterproof
```

from the root directory.

To execute tests against the Waterproof exercises, run
```
dune test
```
## Branch setup for the composed build

As of today, we have two specific branches for the Waterproof proof
mode setup, in particular for Rocq and Waterproof, we store the
changes in the `wp_proof_mode` branch at the impermeable repository:

- https://github.com/impermeable/coq-waterproof/tree/wp_proof_mode
- https://github.com/impermeable/rocq/tree/wp_proof_mode
- stdlib: we use the main branch
- coq-lsp: we use the main branch
