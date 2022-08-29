#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include "cycle.h"
#include <sys/times.h>
#include <sys/resource.h>


int main(){
	long long i,resultado=0;
	float t1,t2;
	t1 = GetTime(); 
	// Inicio del programa a medir
	for (i=0; i<1000000;i++)
	resultado= resultado+i;
	// Fin del programa a medir
	t2=GetTime();
	printf("Milisegundos = %9f\n",t2-t1);
}