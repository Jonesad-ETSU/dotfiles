all:
	gcc lemon.top.c -o lemontopc -DMAIN
	gcc lemon.top.c -o lemonbottomc -DSECONDARY
	rm -rf ./mainonly
main:
	gcc lemon.top.c -o lemontopc -DMAIN
	rm -rf ./mainonly
secondary:
	gcc lemon.top.c -o lemonbottomc -DSECONDARY
	rm -rf ./mainonly
one:
	gcc lemon.top.c -o lemontopc  -DONE
	touch ./mainonly
