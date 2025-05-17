#include <random>
#include <iostream>
#include <algorithm>
#include <ranges>

auto montecarlo_pi(const int num_iterations)
{
    auto rand = std::random_device();
    auto random_engine = std::default_random_engine(rand());
    auto uniform_dist = std::uniform_real_distribution(0.0, 1.0);

    auto count_inside = 0;
    for(int i = 0; i < num_iterations; ++i)
    {
        const auto x = uniform_dist(random_engine); 
        const auto y = uniform_dist(random_engine);
        if((x * x + y * y) <= 1.0)
        {
            ++count_inside;
        }
    }

    return 4.0 * count_inside / static_cast<double>(num_iterations);
}

int main()
{
    constexpr auto num_iterations = 10'000'000;
    const auto pi1 = montecarlo_pi(num_iterations);
    std::cout << pi1 << std::endl;
}