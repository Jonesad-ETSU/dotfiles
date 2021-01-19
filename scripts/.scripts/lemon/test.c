#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void
main () {
	char* test = "1234";
	char t = 'A';
	printf("Testing\n");
	printf("Printf conversion: %d\n",(int)t);
	printf("atoi: %d\n",atoi(test));
	int count = 0;
	for ( int i = 0; i < strlen(test); i++ ) {  
		printf("test[%d]: %d\n",i,(int)test[i]);
		count = count*100 + (int)test[i];
	}
	printf("%d\n",count);
	
/*	int counter = 0;
	for ( int i = 0; i < 4; i++ ) {
		counter = counter*100 + (int)test[i];
	}
	printf("my method: %s\n",counter);
*/
}
