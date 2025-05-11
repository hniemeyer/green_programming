using System;
using System.Collections.Generic;
using System.Linq;

class Program
{
    static Dictionary<string, int> hondt_method(Dictionary<string, int> votes_per_party, int total_number_of_seats)
    {
        var proportional_votes = votes_per_party
            .SelectMany(entry => Enumerable.Range(1, total_number_of_seats)
                                   .Select(i => (entry.Key, Proportion: (double)entry.Value / i)))
            .OrderByDescending(item => item.Proportion)
            .Take(total_number_of_seats)
            .ToArray();

        var distribution = votes_per_party.ToDictionary(
            entry => entry.Key,
            entry => proportional_votes.Count(p => p.Item1 == entry.Key));

        return distribution;
    }

    static void Main()
    {

        int numParties = 10;
        int numSeats = 50000;

        var votes = new Dictionary<string, int>();

        string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

        for (int i = 0; i < numParties; i++)
        {
            // Convert character array element to string
            string key = chars.Substring(i, 1);

            int value = (i + 1) * 1000;

            // Add to the dictionary
            votes[key] = value;
        }

        var result = hondt_method(votes, numSeats);
        foreach (var val in result)
        {
            Console.WriteLine(val);
        }

    }
}