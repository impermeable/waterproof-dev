.PHONY: all
all: build

PKG_SET=coq-lsp/coq-lsp.install rocq/coq-core.install rocq/rocq-core.install rocq/rocq-runtime.install stdlib/rocq-stdlib.install stdlib/coq-stdlib.install coq-waterproof/coq-waterproof.install

.PHONY: build
build: rocq/config/coq_config.ml
	dune build $(PKG_SET)

# Ideally we could regenerate this on Rocq updates, usually not needed
rocq/config/coq_config.ml: rocq
	EPATH=$(shell pwd) \
	&& cd rocq \
	&& ./configure -no-ask -prefix "$$EPATH/_build/install/default/" \
	        -libdir "$$EPATH/_build/install/default/lib/coq" \
	        -bytecode-compiler yes \
		-native-compiler no \
	&& cp theories/dune.disabled theories/dune \
	&& cp user-contrib/Ltac2/dune.disabled user-contrib/Ltac2/dune

.PHONY: clean
clean:
	dune clean

# Test
.PHONY: test
launch: build
	echo "Test not implemented"

# Launch where the _CoqProject file is
.PHONY: launch
launch: build
	dune exec -- code coq-waterproof/

# Install opam deps
.PHONY: opam-deps
opam-deps:
	opam install ./rocq/rocq-runtime.opam -y --deps-only --with-test
	opam install ./coq-lsp/coq-lsp.opam -y --deps-only --with-test
