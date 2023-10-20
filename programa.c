#include <stdio.h>

int main(){
	char nom[20];
	int edat;

	scanf("%s", nom);
	scanf("%d", &edat);
	printf("Hello %s! You are currently %d years old!\n", nom, edat);
}
