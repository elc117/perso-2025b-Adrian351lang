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

PORT = 3000

run:
	@echo "abrindo o servidor na porta $(PORT)"
	$(CC) $(CFLAGS) $(MODULES) $(RUN_FILE).hs
	./$(RUN_FILE)
	$(REMOVE) $(RUN_FILE)

test:
	@echo "realizando testes com HUnit"
	$(CC) $(CFLAGS) $(MODULES) $(TEST_FILE).hs
	./$(TEST_FILE)
	$(REMOVE) $(TEST_FILE)

setup:
	@echo "instalando as dependências"
	$(PKGMAN) install --lib $(PKGS)
