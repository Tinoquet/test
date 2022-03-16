##
## EPITECH PROJECT, 2022
## Makefile
## File description:
## Makefile for MinilibC project
##

PROJECT		=	libasm.so

SRC			=	$(wildcard *.asm)

OBJ			=	$(SRC:.asm=.o)

COMPILER	=	nasm -f elf64 

%.o: %.asm
	$(COMPILER) $< -o $@

all: $(PROJECT)  
	@echo -e "Successful make" 

$(PROJECT):	$(OBJ)
	@echo "Building..."
	@ld -o $(PROJECT) $(OBJ) -shared
	@echo -e "Successful build"

debug: $(OBJ)
	@echo "Building test executable..."
	@gcc -o ex_test test/main.c $(OBJ)
	@echo "Successful build!! Finger crossed"

clean:
	@echo -e "Throwing trash away..."
	@rm -f $(OBJ)
	@rm -f main.o
	@rm -f *.gcno
	@rm -f *.gcda
	@rm -f vgcore.*
	@echo -e "Trash successfuly thrown away"

fclean:	clean
	@echo -e "vvrrrrrrrrmmmmm !!!!!!!!!!!!!!"
	@rm -f $(PROJECT)
	@rm -f ex_test
	@echo -e "Vacuming done"

re:	fclean all

.PHONY:	all $(PROJECT) debug clean fclean re
