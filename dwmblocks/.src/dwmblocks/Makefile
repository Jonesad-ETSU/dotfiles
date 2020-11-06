PREFIX ?= /usr/local
CC ?= gcc

output: dwmblocks.c blocks.def.h blocks.h
		${CC} -c dwmblocks.c -o dwmblocks.o 
		${CC} -o dwmblocks dwmblocks.o `pkg-config --cflags x11 --libs x11`
blocks.h:
	cp blocks.def.h $@


clean:
	rm -f *.o *.gch dwmblocks blocks.h
install: output
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	install -m 0755 dwmblocks $(DESTDIR)$(PREFIX)/bin/dwmblocks
uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/dwmblocks
