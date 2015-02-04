# 
# Makefile for Morse library
# 

doc: config.ld src/morse.lua README.md CHANGELOG.md
	rm -rf doc
	ldoc .


test: src/morse.lua test/test.lua
	cd test; lua test.lua


rockspec: src/morse.lua
	@echo "To be implemented; it would be nice if we could read the version from"
	@echo "the Lua source and use it in the rockspec"


clean:
	rm -rf *~ src/*~ test/*.out test/*~ examples/*~


realclean: clean
	rm -rf doc *.rockspec


.phony: clean realclean
