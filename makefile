NAME = morse

default:
	ghc $(NAME).hs
	./$(NAME)
	rm $(NAME) $(NAME).hi $(NAME).o
