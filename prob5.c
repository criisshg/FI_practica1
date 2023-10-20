

#include <stdio.h>
#include <stdlib.h>
#define MAX 30
int Edat[MAX];
void Init () {
	int i ;
	for (i=0; i<MAX; i++){
		Edat[i] = rand()%100+1;
		printf("%d - > %d \n", i, Edat[i]);
		fflush (stdout); }}
int main () {
	int i, majors=0;
	Init ();
	for (i=0; i<MAX; i++) {
		if (Edat[i] >= 30)
			{ majors++; }
	}
	printf ("El nombre de majors de 30 anys és: %d \n ", majors);
	return 0;}

