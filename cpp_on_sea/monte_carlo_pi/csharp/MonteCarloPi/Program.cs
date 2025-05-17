using System;
using System.Linq;

class Program
{
    public static double montecarlo_pi(int numIterations)
    {
        int insideCircle = 0;
        Random rand = new Random();

        for (int i = 0; i < numIterations; i++)
        {
            double x = rand.NextDouble();
            double y = rand.NextDouble();

            if (x * x + y * y <= 1.0)
            {
                insideCircle++;
            }
        }

        return 4.0 * insideCircle / (double)numIterations;
    }

    static void Main()
    {
        int numIterations = 10000000;
        Console.WriteLine($"Estimated Pi: {montecarlo_pi(numIterations)}");
    }
}
