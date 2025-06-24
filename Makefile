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
	&& cp theories/Corelib/dune.disabled theories/Corelib/dune \
	&& cp theories/Ltac2/dune.disabled theories/Ltac2/dune

# We set windows parameters a bit better, note the need to use forward
# slashed (cygpath -m) due to escaping :( , a conversion to `-w` is
# welcomed if someones has time for this
.PHONY: winconfig
winconfig:
	EPATH=$(shell cygpath -am .) \
	&& cd rocq \
	&& ./configure -no-ask -prefix "$$EPATH\\_build\\install\\default\\" \
	        -libdir "$$EPATH\\_build\\install\\default\\lib\\coq\\" \
		-native-compiler no \
	&& cp theories/Corelib/dune.disabled theories/Corelib/dune \
	&& cp theories/Ltac2/dune.disabled theories/Ltac2/dune

.PHONY: clean
clean:
	dune clean

# Test
.PHONY: test
test: build
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

# Initialise submodules
.PHONY: submodules-init
submodules-init:
	git submodule update --init

# Update submodules from upstream
.PHONY: submodules-update
submodules-update:
	(cd rocq                 && git checkout master     && git pull origin master)
	(cd stdlib               && git checkout master     && git pull origin master)
	(cd coq-lsp              && git checkout main       && git pull origin main)
	(cd coq-waterproof       && git checkout coq-master && git pull origin coq-master)
	(cd waterproof-exercises && git checkout main       && git pull origin main)
