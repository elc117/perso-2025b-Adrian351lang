MODULES_DIR = modules/
MODULES = $(wildcard $(MODULES_DIR)/*.hs)
TEST_FILE = testes
RUN_FILE = site

run:
	ghc $(MODULES) $(RUN_FILE).hs
	./$(RUN_FILE)
	rm *.o *.hi $(RUN_FILE)

test:
	ghc $(MODULES) $(TEST_FILE).hs
	./$(TEST_FILE)
	rm *.o *.hi $(TEST_FILE)