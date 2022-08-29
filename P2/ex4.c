#include <stdio.h>


int main(){
	int a = 0, b = 0;
	for (int i = 0; i < 200; i++){
		if (a > b) a = a-((b+a)/2);
	}
}