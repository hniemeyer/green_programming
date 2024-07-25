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