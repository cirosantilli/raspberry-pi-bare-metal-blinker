#include <stdint.h>

/* This is bad. Anything remotely serious should use timers
 * provided by the board. But this makes the code simpler. */
#define BUSY_WAIT __asm__ __volatile__("")
#define BUSY_WAIT_N 0x100000

int main( void ) {
    uint32_t i;
    /* At the low level, everything is done by writing to magic memory addresses. */
    volatile uint32_t * const GPFSEL4 = (uint32_t *)0x3F200010;
    volatile uint32_t * const GPFSEL3 = (uint32_t *)0x3F20000C;
    volatile uint32_t * const GPSET1  = (uint32_t *)0x3F200020;
    volatile uint32_t * const GPCLR1  = (uint32_t *)0x3F20002C;

    *GPFSEL4 = (*GPFSEL4 & ~(7 << 21)) | (1 << 21);
    *GPFSEL3 = (*GPFSEL3 & ~(7 << 15)) | (1 << 15);
    while (1) {
        *GPSET1 = 1 << (47 - 32);
        *GPCLR1 = 1 << (35 - 32);
        for (i = 0; i < BUSY_WAIT_N; ++i) { BUSY_WAIT; }
        *GPCLR1 = 1 << (47 - 32);
        *GPSET1 = 1 << (35 - 32);
        for (i = 0; i < BUSY_WAIT_N; ++i) { BUSY_WAIT; }
    }
}
