#include <algorithm>
#include <iostream>
#include <map>
#include <string>
#include <vector>
#include <ranges>
#include <random>

struct party_and_proportion
{
    std::string party;
    double proportion;
};

const auto divide_by_seat_divisors = [](const auto& votes_and_divisor)
{
    const auto& [party_and_vote, divisor] = votes_and_divisor;
    return party_and_proportion{ party_and_vote.first, party_and_vote.second / static_cast<double>(divisor) };
};

auto calculate_number_of_seats(
    const std::vector<party_and_proportion>& proportional_votes,
    const int total_number_of_seats,
    const std::string_view party)
{
    return std::ranges::count_if(proportional_votes | std::views::take(total_number_of_seats), [&](const auto& party_and_votes)
    {
        return party_and_votes.party == party;
    });
}

auto count_seats_per_party(const std::vector<party_and_proportion>& proportional_votes, const int total_number_of_seats)
{
    return [&, total_number_of_seats](const auto& party)
    {
        const auto seats = calculate_number_of_seats(proportional_votes, total_number_of_seats, party);
        return std::pair{ party, seats };
    };
}

auto hondt_method(const std::map<std::string, int>& votes_per_party, const int total_number_of_seats)
{
    const auto seat_divisors = std::views::iota(1, total_number_of_seats + 1);
    auto proportional_votes = std::views::cartesian_product(votes_per_party, seat_divisors)
        | std::views::transform(divide_by_seat_divisors)
        | std::ranges::to<std::vector>();

    std::ranges::sort(proportional_votes, std::greater(), &party_and_proportion::proportion);

    return votes_per_party
        | std::views::keys
        | std::views::transform(count_seats_per_party(proportional_votes, total_number_of_seats))
        | std::ranges::to<std::map>();
}

int random_int(int min, int max) {
    static std::random_device rd;  
    static std::mt19937 gen(rd()); 
    std::uniform_real_distribution<> dis(min, max);
    return dis(gen);
}


std::string random_party_name() {
    const static std::string charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    static std::random_device rd;
    static std::mt19937 gen(rd());
    std::uniform_int_distribution<> len_dis(1, 10);
    std::uniform_int_distribution<> char_dis(0, charset.size() - 1);

    int length = len_dis(gen);
    std::string random_string;
    random_string.reserve(length);

    for (int i = 0; i < length; ++i) {
        random_string += charset[char_dis(gen)];
    }

    return random_string;
}

int main()
{
    int num_parties = 1000;
    int max_votes = 1000;
    auto votes = std::map<std::string, int>();
    for (int i=0; i<num_parties; ++i) {
        votes[random_party_name()] = random_int(1,max_votes);
    }

    const auto distribution = hondt_method(votes, 500);
    for (const auto& vote : distribution)
    {
        std::cout << vote.first << " " << vote.second << "\n";
    }

    std::cout << "\n";
}