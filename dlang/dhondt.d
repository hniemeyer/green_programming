import std.stdio;
import std.range;
import std.container;
import std.typecons;
import std.algorithm;
import std.random;
import std.array;
import std.conv : to;

struct party_and_votes
{
    string party;
    int votes;
}

struct party_and_proportional_votes
{
    string party;
    double proportional_votes;
}

struct party_and_seats
{
    string party;
    ulong seats;
}

auto hondt_method(party_and_votes[] votes_per_party, immutable int total_number_of_seats)
{
    auto proportional_votes = new party_and_proportional_votes[votes_per_party.length * total_number_of_seats];
    auto idx = 0;
    foreach(i; iota(1, total_number_of_seats + 1))
    {
        foreach (immutable vote_party; votes_per_party)
        {
            proportional_votes[idx++] = party_and_proportional_votes(vote_party.party, double(vote_party.votes) / i);
        }
    }

    proportional_votes.sort!("a.proportional_votes > b.proportional_votes");
    proportional_votes.length = total_number_of_seats;

    auto distribution = new party_and_seats[votes_per_party.length];
    foreach (immutable i, vote_party; votes_per_party.enumerate)
    {
        distribution[i] = party_and_seats(vote_party.party, 
            count!("a == b")(proportional_votes.map!(party_and_proportional_votes => party_and_proportional_votes.party), vote_party.party));
    }

    return distribution;
}

string generateRandomPartyName()
{
    string alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int length = uniform(1, 11); // Random length between 1 and 10
    string name;
    foreach (i; 0 .. length)
    {
        name ~= alphabet[uniform(0, alphabet.length)];
    }
    return name;
}

party_and_votes generateRandomPartyVotes(int maxVotes)
{
    auto randParty = generateRandomPartyName();
    auto randVotes = uniform(0, maxVotes);
    return party_and_votes(randParty, randVotes);
}

auto generateRandomData(int count)
{
    int maxVotes = 1000;

    party_and_votes[] data;
    foreach (i; 0 .. count)
    {
        data ~= generateRandomPartyVotes(maxVotes);
    }

    return data;
}

void main()
{
    auto votes = generateRandomData(1000);

    auto result = hondt_method(votes, 500);

    writeln(result);
}