#include <stdio.h>
int global_a;
int global_b;
void function1(){
    global_a = 2;
    global_b = 3;
    int local_a = 4;
    int local_b = 5;
}
int main(){
    function1();
    return 0;
}