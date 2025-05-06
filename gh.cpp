#include <stdio.h>
#include <stdint.h>

int main() {
    uint32_t state[4];
    uint32_t seed;

    printf("Initial number: ");
    scanf_s("%u", &seed); 

    state[0] = seed;
    state[1] = seed ^ 1;
    state[2] = seed ^ 2;
    state[3] = seed ^ 3;

    printf("The numbers generated are: \n");
 
    for (int i = 0; i < 100; i++) {
        uint32_t t = state[3];
        const uint32_t s = state[0];

        state[3] = state[2];
        state[2] = state[1];
        state[1] = s;

        t = t ^ t << 11;
        t = t ^ t >> 8;
        t = t ^ s ^ (s >> 19);

        state[0] = t;
		  printf("%u ", i);
		  printf("%u\n", t);
    }

    return 0;
}
