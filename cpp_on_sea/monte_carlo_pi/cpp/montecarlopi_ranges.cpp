#include <random>
#include <iostream>
#include <algorithm>
#include <ranges>

auto montecarlo_pi_ranges(const int num_iterations)
{
    auto rand = std::random_device();
    auto random_engine = std::default_random_engine(rand());
    auto uniform_dist = std::uniform_real_distribution(0.0, 1.0);

    auto count_range = std::views::iota(0, num_iterations) | std::views::filter([&](const auto){ 
        const auto x = uniform_dist(random_engine); 
        const auto y = uniform_dist(random_engine);
        return (x * x + y * y) <= 1.0;
        });

    return 4.0 * std::ranges::distance(count_range) / static_cast<double>(num_iterations);
}

int main()
{
    constexpr auto num_iterations = 10'000'000;
    const auto pi2 = montecarlo_pi_ranges(num_iterations);
    std::cout << pi2 << std::endl;
}