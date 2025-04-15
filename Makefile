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

.PHONY: build
build:
	dune build -p coq-waterproof

.PHONY: all
all: rocq/config/coq_config.ml build
