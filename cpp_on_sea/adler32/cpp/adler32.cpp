#include <iostream>
#include <vector>
#include <cstddef>
#include <algorithm>
#include <ranges>

uint32_t adler32(const std::vector<uint8_t>& data) 
{
    const uint32_t mod_adler = 65521;

    uint32_t a = 1;
    uint32_t b = 0;

    for (size_t i = 0; i < data.size(); ++i) 
    {
        a = (a + data[i]) % mod_adler;
        b = (b + a) % mod_adler;
    }

    return (b << 16) | a;
}


int main() 
{
    std::vector<std::uint8_t> data = {1, 2, 3, 4, 5};
    uint32_t checksum1 = adler32(data);
    std::cout << "Adler-32 check sum: " << checksum1 << std::endl;

}
