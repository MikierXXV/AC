#include <stdio.h>
#define N 10
#define M 100

int Matriz[N][N],i,j,ResFila[N];

int main(){

	for (i=0,j=0,ResFila[0]=1;i<N;i++,j=0,ResFila[i]=1){
		while(Matriz[i][j]!=0) {
			if (Matriz[i][j]>M)
			ResFila[i]-=Matriz[i][j];
			j++;
		}
	}
}