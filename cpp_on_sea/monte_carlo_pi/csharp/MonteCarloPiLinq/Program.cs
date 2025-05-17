using System;
using System.Linq;

class Program
{
    public static double montecarlo_pi_with_linq(int numIterations)
    {
        Random rand = new Random();
        var points = Enumerable.Range(0, numIterations).Select(_ => new { X = rand.NextDouble(), Y = rand.NextDouble() });
        int insideCircle = points.Count(p => p.X * p.X + p.Y * p.Y <= 1.0);

        return 4.0 * insideCircle / (double)numIterations;
    }

    static void Main()
    {
        int numIterations = 10000000;
        Console.WriteLine($"Estimated Pi: {montecarlo_pi_with_linq(numIterations)}");
    }
}
