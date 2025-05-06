#include <stdio.h>
#include <stdint.h>

struct xorshift128_state {
    uint32_t a, b, c, d;
};

struct xorshift128_state state;

void xorshift128_init(uint32_t seed) {
    state.a = seed;
    state.b = seed;
    state.b ^= 0x5DEECE66D;
    state.c = seed;
    state.c ^= 0xB16B00B5;
    state.d = seed;
    state.d ^= 0xDEADBEEF;
}

uint32_t xorshift128() {
    uint32_t t = state.d;

    uint32_t s = state.a;
    state.d = state.c;
    state.c = state.b;
    state.b = s;

    t ^= t << 11;
    t ^= t >> 8;
    state.a = t ^ s ^ (s >> 19);

    return state.a;
}

int main() {

    uint32_t seed;
    printf("Initial number: ");
    scanf_s("%u", &seed);

    xorshift128_init(seed);

    printf("The numbers generated are: \n");

    int i = 0;

cycle_start:
    if (i >= 100) goto if_end;

    printf("%u\n", xorshift128());

    i += 1;
    goto cycle_start;

if_end:
    return 0;
}
