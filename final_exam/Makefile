SRC= ex3.s 
OBJ= ex3.o 
PROGRAM= ex3 

all: $(PROGRAM)

$(OBJ): $(SRC)
	sisa-as --gstabs+ -o $(OBJ) $(SRC)

$(PROGRAM): $(OBJ)
	sisa-ld -o $(PROGRAM) $(OBJ)

clean:
	rm -rf $(OBJ) $(PROGRAM)

test:
	sisa-dbg $(PROGRAM)
