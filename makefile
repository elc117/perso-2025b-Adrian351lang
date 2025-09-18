NAME = morse

default:
	ghc -dynamic $(NAME).hs
	./$(NAME)
	rm $(NAME) $(NAME).hi $(NAME).o