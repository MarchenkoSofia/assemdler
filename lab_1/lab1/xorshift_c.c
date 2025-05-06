#include <stdio.h>
#include <stdint.h>

struct xorshift128_state {
    uint32_t a, b, c, d;
};


struct xorshift128_state state;


void xorshift128_init(uint32_t seed) {
    state.a = seed;
    state.b = seed ^ 0x5DEECE66D; 
    state.c = seed ^ 0xB16B00B5; 
    state.d = seed ^ 0xDEADBEEF; 
}


uint32_t xorshift128() {
    uint32_t t = state.d;

    uint32_t const s = state.a;
    state.d = state.c;
    state.c = state.b;
    state.b = s;

    t ^= t << 11;
    t ^= t >> 8;
    return state.a = t ^ s ^ (s >> 19);
}


int main() {
    uint32_t seed;

    printf("Initial: ");
    scanf_s("%u", &seed);

    xorshift128_init(seed);

    printf("Generated numbers:\n");
    for (int i = 0; i < 100; i++) {
        printf("%u\n", xorshift128());
    }

    return 0;
}
