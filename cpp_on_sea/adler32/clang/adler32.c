#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>


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
    const size_t N = 50000000;  // 50 million elements
    
    // Allocate array of uint8_t on the heap
    uint8_t *array = malloc(N * sizeof(uint8_t));
    if (array == NULL) {
        fprintf(stderr, "Failed to allocate memory for %zu elements.\n", N);
        return EXIT_FAILURE;
    }

    // Seed the random number generator
    srand((unsigned)time(NULL));

    // Fill the array with random values between 0 and 255
    for (size_t i = 0; i < N; ++i) {
        array[i] = (uint8_t)(rand() % 256);
    }

    const uint32_t checksum = adler32(array, N);
    printf("Adler-32 Checksumme: %u\n", checksum);

}