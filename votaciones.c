#include<stdio.h>
#include<stdlib.h>
#include<windows.h>

int menu();

int main(){
    int F=0,J=0,A=0;
    char dato[5];
    char re='s';
    char datos[200]="https://quickchart.io/chart?cht=bvs&chxt=y&chs=800x500&chco=ffff99|99ffff|ff99ff&chl=Freddy|Jason|Ash&chd=t: ";

    do{
        system("Color 2");
        system("CLS");
         switch(menu()){
        case 1:
            F++;
            break;
        case 2:
            J++;
            break;
        case 3:
            A++;
            break;
        default:
            break;
        }
        printf("Continuas [S/N]: ");
        scanf("%s",&re);
    }while(re=='S' || re=='s');

    printf("\n\n\n Freddy%d     El Jason%d      El Ash%d\n\n",F,J,A);
    system("PAUSE");

    itoa(F,dato,10);
    strcat(datos,dato);
    strcat(datos,",");

    itoa(J,dato,10);
    strcat(datos,dato);
    strcat(datos,",");

    itoa(A,dato,10);
    strcat(datos,dato);

    ShellExecute(0,"open",datos,"","",1);
}

int menu(){
int op;
printf("------------------\nEl mas fuerte\n-------------------\n\t 1-Freddy\n\t 2-Jason\n\t 3-Ash\n\n---------------------\n");
printf("Selecciona a tu candidato: ");
scanf("%d",&op);
return op;
}
