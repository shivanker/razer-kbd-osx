all: razer-led

clean:
	rm *.o razer-led

razer-led: razercommon.o razerchromacommon.o razerkbd_driver.o main.o
	gcc -framework CoreFoundation -framework IOKit -o $@ $^
 
main.o: main.c
	gcc -c main.c
 
%.o: %.c
	gcc -c $<

