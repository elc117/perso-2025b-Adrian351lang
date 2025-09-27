CC = ghc
REMOVE = rm
# -dynamic pode não ser necessário
CFLAGS = -dynamic

MODULES_DIR = modules
MODULES = $(wildcard $(MODULES_DIR)/*.hs)
MAIN_DIR = main
TEST_FILE = $(MAIN_DIR)/testes
RUN_FILE = $(MAIN_DIR)/site

PKGMAN = cabal
PKGS = scotty text HUnit

run:
	$(CC) $(CFLAGS) $(MODULES) $(RUN_FILE).hs
	./$(RUN_FILE)
	$(REMOVE) $(RUN_FILE)

test:
	$(CC) $(CFLAGS) $(MODULES) $(TEST_FILE).hs
	./$(TEST_FILE)
	$(REMOVE) $(TEST_FILE)

setup:
	$(PKGMAN) install --lib $(PKGS)
