GCC=gcc
OBJS=pgm.o

all: pgm_exe

%.o: %.c 
	$(GCC) -c -g $^

pgm_exe: $(OBJS)
	$(GCC) -o $@ $<

clean:
	rm -rf *.o pgm_exe

