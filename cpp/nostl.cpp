#include <iostream>
#include <random>

struct party_and_proportional_votes
{
    const char* party;
    double proportional_votes;
};

namespace quicksort
{
    int partition(party_and_proportional_votes* arr, const int low, const int high) 
    {
        const int pivot = arr[high].proportional_votes;
        int i = low - 1;
    
        for (int j = low; j < high; ++j) 
        {
            if (arr[j].proportional_votes > pivot) 
            {
                party_and_proportional_votes temp = arr[++i];
                arr[i] = arr[j];
                arr[j] = temp;
            }
        }
    
        const party_and_proportional_votes temp = arr[i + 1];
        arr[i + 1] = arr[high];
        arr[high] = temp;
    
        return i + 1;
    }
    
    void quicksort(party_and_proportional_votes* arr, const int low, const int high) 
    {
        if (low < high) 
        {
            const int pivot = partition(arr, low, high);
            quicksort(arr, low, pivot - 1);
            quicksort(arr, pivot + 1, high);
        }
    }
}

struct party_and_votes
{
    const char* party;
    int votes;
};

struct party_and_seats
{
    const char* party;
    int votes;
};

party_and_seats* hondt_method(const party_and_votes* votes_per_party, const int size_votes_per_party, const int total_number_of_seats)
{
    const int size_proportional_votes = size_votes_per_party * total_number_of_seats;
    party_and_proportional_votes* proportional_votes = new party_and_proportional_votes[size_proportional_votes];
    int k = 0;
    for (int i = 1; i < total_number_of_seats + 1; ++i)
    {
        for (int j = 0; j < size_votes_per_party; ++j)
        {
            proportional_votes[k++] = party_and_proportional_votes{ votes_per_party[j].party, static_cast<double>(votes_per_party[j].votes) / i };
        }
    }

    quicksort::quicksort(proportional_votes, 0, size_proportional_votes - 1);

    party_and_seats* distribution = new party_and_seats[size_votes_per_party];
    for (int i = 0; i < size_votes_per_party; ++i)
    {
        int seats = 0;
        const char* party = votes_per_party[i].party;
        for(int j = 0; j < total_number_of_seats; ++j)
        {
            if(party == proportional_votes[j].party)
            {
                ++seats;
            }
        }
        distribution[i] = party_and_seats{party, seats};
    }

    delete[] proportional_votes;

    return distribution;
}

double random_int(int min, int max) {
    static std::random_device rd;  
    static std::mt19937 gen(rd()); 
    std::uniform_real_distribution<> dis(min, max);
    return dis(gen);
}


const char* random_party_name() {
    static const char charset[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    static std::random_device rd;
    static std::mt19937 gen(rd());
    std::uniform_int_distribution<> len_dis(1, 10);
    std::uniform_int_distribution<> char_dis(0, sizeof(charset) - 2);

    int length = len_dis(gen);
    char* party_name = new char[length + 1];
    for (int i = 0; i < length; ++i) {
        party_name[i] = charset[char_dis(gen)];
    }
    party_name[length] = '\0';

    return party_name;
}

int main() 
{

    int num_parties = 10;
    int max_votes = 1000;

    // Dynamically allocate array of party names
    const char** parties = new const char*[num_parties];
    for (int i = 0; i < num_parties; ++i) {
        parties[i] = random_party_name();
    }

    // Generate random party_and_proportional_votes
    party_and_votes* votes = new party_and_votes[num_parties];
    for (int i = 0; i < num_parties; ++i) {
        votes[i].party = parties[i];
        votes[i].votes = random_int(1.0, max_votes);
    }

    party_and_seats* result = hondt_method(votes, num_parties, 10);
    for(int i = 0; i < num_parties; ++i)
    {
        std::cout << result[i].party << " " << result[i].votes << "\n";
    }
    std::cout << "\n";

    delete[] votes;
    delete[] result;
}