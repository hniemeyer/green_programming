import std.stdio;
import std.range;
import std.container;
import std.typecons;
import std.algorithm;

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

auto hondt_method(immutable party_and_votes[] votes_per_party, immutable int total_number_of_seats)
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

void main()
{
    immutable auto votes = [party_and_votes("party_1", 110), 
                            party_and_votes("party_2", 85), 
                            party_and_votes("party_3", 35)];

    immutable auto result = hondt_method(votes, 7);

    writeln(result);

    immutable auto votes2 = [party_and_votes("party_1", 10000), 
                             party_and_votes("party_2", 6000), 
                             party_and_votes("party_3", 1500)];

    immutable auto result2 = hondt_method(votes2, 8);

    writeln(result2);
}