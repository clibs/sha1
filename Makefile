CFLAGS=-g -O0 -std=c99
LINKER=-lcunit
SOURCES=test.c sha1.c
TESTBINARY=sha1test

.FORCE: test
all:
	make test

clean:
	rm -rf *.o sha1test

test:
	$(CC) $(CFLAGS) -o $(TESTBINARY) $(SOURCES) $(LINKER)
	./sha1test	
