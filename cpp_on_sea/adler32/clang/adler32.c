#include <stdint.h>
#include <stddef.h>
#include <stdio.h>

uint32_t adler32(const uint8_t *buffer, const size_t buffer_length)
{
    const uint32_t mod_adler = 65521;

    uint32_t s1 = 1;
    uint32_t s2 = 0;

    for (size_t n = 0; n < buffer_length; n++) 
    {
        s1 = (s1 + buffer[n]) % mod_adler;
        s2 = (s2 + s1) % mod_adler;
    }

    return (s2 << 16) | s1;
}

int main()
{
    const size_t buffer_length = 5;
    const uint8_t data[] = {1, 2, 3, 4, 5};
    const uint32_t checksum = adler32(data, buffer_length);
    printf("Adler-32 Checksumme: %u\n", checksum);
}