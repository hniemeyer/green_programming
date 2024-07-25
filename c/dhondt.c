#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

typedef struct 
{
    char* party;
    int votes;
} party_and_votes;

typedef struct 
{
    char* party;
    double proportional_votes;
} party_and_proportion;

typedef struct 
{
    char* party;
    int seats;
} party_and_seats;

int compare_proportional_votes(const void* a, const void* b) 
{
    party_and_proportion* pa = (party_and_proportion*)a;
    party_and_proportion* pb = (party_and_proportion*)b;
    return (pa->proportional_votes < pb->proportional_votes) - (pa->proportional_votes > pb->proportional_votes);
}

party_and_seats* hondt_method(party_and_votes* votes_per_party, int party_count, int total_number_of_seats) 
{
    int proportional_votes_size = total_number_of_seats * party_count;
    party_and_proportion* proportional_votes = (party_and_proportion*)malloc(proportional_votes_size * sizeof(party_and_proportion));
    int index = 0;

    for (int i = 1; i <= total_number_of_seats; ++i) 
    {
        for (int j = 0; j < party_count; ++j) 
        {
            proportional_votes[index].party = votes_per_party[j].party;
            proportional_votes[index].proportional_votes = (double)votes_per_party[j].votes / i;
            index++;
        }
    }

    qsort(proportional_votes, proportional_votes_size, sizeof(party_and_proportion), compare_proportional_votes);

    party_and_seats* seats = (party_and_seats*)malloc(party_count * sizeof(party_and_seats));
    for (int i = 0; i < party_count; ++i) 
    {
        int count = 0;
        for (int j = 0; j < total_number_of_seats; ++j) 
        {
            if (strcmp(proportional_votes[j].party, votes_per_party[i].party) == 0) 
            {
                count++;
            }
        }

        seats[i].party = votes_per_party[i].party;
        seats[i].seats = count;
    }

    free(proportional_votes);

    return seats;
}

int random_int(int min, int max) {
    return min + (rand() / (RAND_MAX / (max - min)));
}

char* random_party_name() {
    static const char charset[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    int length = rand() % 10 + 1; // Length between 1 and 10
    char* party_name = (char*)malloc((length + 1) * sizeof(char));
    if (!party_name) {
        return NULL; // Check for memory allocation failure
    }
    for (int i = 0; i < length; ++i) {
        party_name[i] = charset[rand() % (sizeof(charset) - 1)];
    }
    party_name[length] = '\0';
    return party_name;
}

int main() 
{
    int num_parties = 1000;
    int max_votes = 1000;
    int number_of_seats = 500;

    party_and_votes* votes = (party_and_votes*)malloc(num_parties * sizeof(party_and_votes));

    for (int i = 0; i < num_parties; ++i) {
        votes[i].party = random_party_name();  
        votes[i].votes = random_int(1,max_votes);          // Example vote count
    }

    party_and_seats* result = hondt_method(votes, num_parties, number_of_seats);
    for(int i = 0; i < num_parties; ++i)
    {
        printf("%s %i\n", result[i].party, result[i].seats);
    }

    printf("\n");

    free(result);
    free(votes);
}