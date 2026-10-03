/* Minimal portable build example: no board pin assumptions or Arduino core. */
#include <avr/io.h>

int main(void)
{
    for (;;) {
        __asm__ __volatile__("nop");
    }
}
