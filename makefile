# caso queira mudar o compilador, flags e gerenciador de pacotes, só mudar aqui
# -dynamic pode não ser necessário
CC = ghc
CFLAGS = -dynamic
PKGMAN = cabal
PKGS = scotty text HUnit

# localização dos arquivos, mudar caso for movê-los
MODULES_DIR = modules
MODULES = $(wildcard $(MODULES_DIR)/*.hs)
MAIN_DIR = main
TEST_FILE = $(MAIN_DIR)/testes
RUN_FILE = $(MAIN_DIR)/site

REMOVE = rm
PORT = 3000

# esse procedimento abre o servidor
run:
	@echo "abrindo o servidor na porta $(PORT)"
	$(CC) $(CFLAGS) $(MODULES) $(RUN_FILE).hs
	./$(RUN_FILE)
	$(REMOVE) $(RUN_FILE)

# esse procedimento realiza os testes com HUnit
test:
	@echo "realizando testes com HUnit"
	$(CC) $(CFLAGS) $(MODULES) $(TEST_FILE).hs
	./$(TEST_FILE)
	$(REMOVE) $(TEST_FILE)

# esse procedimento instala as dependências
setup:
	@echo "instalando as dependências"
	$(PKGMAN) install --lib $(PKGS)
