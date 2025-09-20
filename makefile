MODULES = bases.hs morse.hs
TEST_FILE = testes
RUN_FILE = scotty

run:
	ghc $(MODULES) $(RUN_FILE)
	./$(RUN_FILE)
	rm *.o *.hi
test:
	ghc $(MODULES) $(TEST_FILE)
	./$(TEST_FILE)
	rm *.o *.hi