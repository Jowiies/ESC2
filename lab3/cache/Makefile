SRC= cache.s 
OBJ= cache.o 
PROGRAM= cache 

all: $(PROGRAM)

$(OBJ): $(SRC)
	sisa-as --gstabs+ -o $(OBJ) $(SRC)

$(PROGRAM): $(OBJ)
	sisa-ld -o $(PROGRAM) $(OBJ)

clean:
	rm -rf $(OBJ) $(PROGRAM)

test:
	sisa-dbg $(PROGRAM)
