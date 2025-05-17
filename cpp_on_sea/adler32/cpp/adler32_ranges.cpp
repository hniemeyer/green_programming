#include <iostream>
#include <vector>
#include <cstddef>
#include <algorithm>
#include <ranges>

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
    std::vector<std::uint8_t> data = {1, 2, 3, 4, 5};
    uint32_t checksum2 = adler32_ranges(data);
    std::cout << "Adler-32 check sum: " << checksum2 << std::endl;
}
