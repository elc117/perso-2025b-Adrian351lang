CC = ghc
REMOVE = rm

MODULES_DIR = modules
MODULES = $(wildcard $(MODULES_DIR)/*.hs)
MAIN_DIR = main
TEST_FILE = $(MAIN_DIR)/testes
RUN_FILE = $(MAIN_DIR)/site

PKGMAN = cabal
PKGS = scotty text

run:
	$(CC) $(MODULES) $(RUN_FILE).hs
	./$(RUN_FILE)
	$(REMOVE) $(RUN_FILE)

test:
	$(CC) $(MODULES) $(TEST_FILE).hs
	./$(TEST_FILE)
	$(REMOVE) $(TEST_FILE)

setup:
	$(PKGMAN) install --lib $(PKGS)