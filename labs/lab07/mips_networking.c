// Reads a 4-byte value and reverses the byte order, then prints it

#include <stdint.h>
#include <stdio.h>

#define BYTE_MASK 0xFF

int main(void) {
    int32_t network_bytes;
    scanf("%d", &network_bytes);

    int32_t computer_bytes = 0;
    uint32_t byte_mask = BYTE_MASK;

    computer_bytes |= (network_bytes & byte_mask) << 24;
    computer_bytes |= (network_bytes & (byte_mask << 8)) << 8;
    computer_bytes |= (network_bytes & (byte_mask << 16)) >> 8;
    computer_bytes |= (network_bytes & (byte_mask << 24)) >> 24;

    printf("%d", computer_bytes);

    return 0;
}