#include <stdio.h>
#include <string.h>
int bad_guy();

void overflow(int p)
{
     int buf[4];
     int i;
     for(i=0;i<4;++i){
         buf[i]=0;
     }
     buf[10]=p;
}

int bad_guy()
{
     printf("Overflow successful\n");
     return 0;
}

int main(int argc, char *argv[])
{
    printf("Address of main = %#X\n", main);
    printf("Address of overflow = %#X\n", overflow);
    printf("Address of bad_guy = %#X\n", bad_guy); 

    overflow(0X00401588);
    return 0;
}