MODULES = modules/*
TEST_FILE = testes
RUN_FILE = scotty

run:
	ghc $(MODULES) $(RUN_FILE)
	./$(RUN_FILE)
	rm *.o *.hi $(RUN_FILE)

test:
	ghc $(MODULES) $(TEST_FILE)
	./$(TEST_FILE)
	rm *.o *.hi $(TEST_FILE)