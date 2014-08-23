# 
# Makefile for Morse library
# 

doc: config.ld src/morse.lua README.md CHANGELOG.md
	rm -rf doc
	ldoc .


rockspec: src/morse.lua
	@echo "To be implemented; it would be nice if we could read the version from"
	@echo "the Lua source and use it in the rockspec"


clean:
	rm -rf *~ src/*~ 

realclean: clean
	rm -rf doc *.rockspec


.phony: clean realclean
