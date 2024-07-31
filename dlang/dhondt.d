import std.stdio;
import std.range;
import std.container;
import std.typecons;
import std.algorithm;
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

auto generateData(int count)
{
    int voteFactor = 1000;
    string alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    party_and_votes[] data;
    foreach (i; 0 .. count)
    {
        string name;
        name ~= alphabet[i];
        data ~= party_and_votes(name,(i+1)*1000);
    }

    return data;
}

void main()
{
    auto votes = generateData(10);

    auto result = hondt_method(votes, 50000);

    writeln(result);
}