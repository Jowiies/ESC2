SRC= sum.s 
OBJ= sum.o 
PROGRAM= sum 

all: $(PROGRAM)

$(OBJ): $(SRC)
	sisa-as --gstabs+ -o $(OBJ) $(SRC)

$(PROGRAM): $(OBJ)
	sisa-ld -o $(PROGRAM) $(OBJ)

clean:
	rm -rf $(OBJ) $(PROGRAM)

test:
	sisa-dbg $(PROGRAM)
