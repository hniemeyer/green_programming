#include <iostream>
#include <vector>
#include <cstddef>
#include <algorithm>
#include <ranges>
#include <random>
#include <chrono>

uint32_t adler32_ranges(const std::vector<uint8_t>& data) 
{
    const uint32_t mod_adler = 65521;
    
    uint32_t a = 1;
    const auto b = std::ranges::fold_left(data, 0, [&](const auto sum, const auto d){ 
        a = (a + d) % mod_adler; 
        return (sum + a) % mod_adler;
        });

    return (b << 16) | a;        
}

int main() 
{
    const std::size_t N = 50'000'000;  // 50 million elements

    // Allocate a vector<uint8_t> on the heap
    std::vector<uint8_t> array;
    array.reserve(N);

    // Seed a Mersenne Twister PRNG with high-resolution clock
    auto seed = std::chrono::high_resolution_clock::now().time_since_epoch().count();
    std::mt19937_64 rng(seed);
    std::uniform_int_distribution<uint16_t> dist(0, 255);

    // Fill the array
    for (std::size_t i = 0; i < N; ++i) {
        array.push_back(static_cast<uint8_t>(dist(rng)));
    }

    uint32_t checksum2 = adler32_ranges(array);
    std::cout << "Adler-32 check sum: " << checksum2 << std::endl;
}
