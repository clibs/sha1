TARGET=$(shell $(CC) -dumpmachine)

CFLAGS=-Wall -Werror

TESTCFLAGS=-g $(CFLAGS) 
TESTLINKER=-lcunit
TESTSOURCES=test.c sha1.c
TESTBINARY=sha1test

SOURCES=sha1.c
OBJECTS=$(patsubst %.c,objs/$(TARGET)/%.c.o,$(SOURCES))

.PHONY: static
.FORCE: test
all:
	make test

lib/$(TARGET):
	mkdir -p $@

objs/$(TARGET):
	mkdir -p $@

objs/$(TARGET)/%.c.o: %.c objs/$(TARGET) lib/$(TARGET)
	$(CC) $(CFLAGS) -c $< -o $@

lib/$(TARGET)/libsha1.a: $(OBJECTS)
	$(AR) rcs $@ $^

static: lib/$(TARGET)/libsha1.a
	@echo "Built $@"

clean:
	rm -rf *.o $(TESTBINARY)
	rm -rf lib out

test:
	$(CC) $(TESTCFLAGS) -o $(TESTBINARY) $(TESTSOURCES) $(TESTLINKER)
	./$(TESTBINARY)	
