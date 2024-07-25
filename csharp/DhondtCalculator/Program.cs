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

        int numParties = 1000;
        int maxVotes = 1000;
        int numSeats = 500;

        var votes = new Dictionary<string, int>();

        Random random = new Random();

        string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

        for (int i = 0; i < numParties; i++)
        {
            // Generate a random string length between 1 and 10
            int stringLength = random.Next(1, 11);

            char[] randomString = new char[stringLength];
            for (int j = 0; j < stringLength; j++)
            {
                randomString[j] = chars[random.Next(chars.Length)];
            }

            // Convert character array to string
            string key = new string(randomString);

            // Generate a random integer between 1 and maxInts
            int value = random.Next(1, maxVotes + 1);

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