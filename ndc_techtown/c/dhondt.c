#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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

int main() 
{
    int num_parties = 10;
    int number_of_seats = 50000;

    party_and_votes* votes = (party_and_votes*)malloc(num_parties * sizeof(party_and_votes));
    char charset[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    for (int i = 0; i < num_parties; ++i) {
        char* party_name = (char*)malloc((2) * sizeof(char));
        party_name[0] = charset[i];
        party_name[1] = '\0';
        votes[i].party = party_name;  
        votes[i].votes = (i+1)*1000;
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