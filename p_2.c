#include <stdio.h>

int factorial( int x ){
	int f = 1;
	int i ;

	for(i=1; i <= x; i++) f = f*i;
	return f;
}

int main(){
	int a, b;

	printf("Introdueix dos números:\n");
	scanf("%d", &a);
	scanf("%d", &b);

	printf("La suma de %d i %d és %d, la resta és %d, la muktiplicació és %d\n",a, b, a+b, a-b, a*b);
	printf("Factorial de %d és %d\n", a, factorial(a));
}

