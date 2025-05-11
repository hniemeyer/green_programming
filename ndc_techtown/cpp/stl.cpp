#include <algorithm>
#include <iostream>
#include <map>
#include <string>
#include <vector>
#include <random>

auto hondt_method(const std::map<std::string, int>& votes_per_party, const int total_number_of_seats)
{
    auto proportional_votes = std::vector<std::pair<std::string, double>>();
    proportional_votes.reserve(total_number_of_seats * votes_per_party.size());
    for (int i = 1; i < total_number_of_seats + 1; ++i)
    {
        for (const auto& [party, number_of_votes] : votes_per_party)
        {
            proportional_votes.push_back({ party, static_cast<double>(number_of_votes) / i });
        }
    }

    std::sort(proportional_votes.begin(), proportional_votes.end(), [](const auto& rhs, const auto& lhs) {return rhs.second > lhs.second; });
    proportional_votes.resize(total_number_of_seats);

    auto distribution = std::map<std::string, int>();
    for (const auto& [party, number_of_votes] : votes_per_party)
    {
        distribution[party] = std::count_if(proportional_votes.begin(), proportional_votes.end(), [&](const auto& votes)
            {
                return votes.first == party;
            });
    }

    return distribution;
}

int main()
{
    int num_parties = 10;
    const std::string charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    auto votes = std::map<std::string, int>();
    for (int i=0; i<num_parties; ++i) {
        std::string party_name = charset.substr(i,1);
        votes[party_name] = (i+1)*1000;
    }

    const auto distribution = hondt_method(votes, 50000);
    for (const auto& vote : distribution)
    {
        std::cout << vote.first << " " << vote.second << "\n";
    }

    std::cout << "\n";
}