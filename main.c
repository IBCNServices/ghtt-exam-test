#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {
    malloc(5000);
    printf("debugging works – FALSE\n");
    return 0;
}