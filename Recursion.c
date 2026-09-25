//Utilizar recursion directa para determinar si un numero es par o impar
#include<stdio.h>
#include<stdbool.h>
bool espar(int n);
bool esimpar(int n);

int main(void){
    for(int i=1;i<=5;i++){
        printf("%d es %s\n",i,espar(i)?"Par":"Impar");
    }
}

bool espar(int n){
    if(n==0) return true;
    if(n<0) return espar(-n);
    return esimpar(n-1);
}

bool esimpar(int n){
    if(n==0) return false;
    if(n<0) return esimpar(n-1);
    return espar(n-1);
}
