import std.stdio;
import std.random;
import std.conv;

double montecarlo_pi(const int num_iterations)
{
    int inside_circle = 0;
    auto randGen = Random(unpredictableSeed);

    for (int i = 0; i < num_iterations; i++) 
    {
        const double x = uniform(0.0, 1.0, randGen);
        const double y = uniform(0.0, 1.0, randGen);

        if (x * x + y * y <= 1.0) 
        {
            inside_circle++;
        }
    }

    return 4.0 * inside_circle / cast(double)num_iterations;
}

void main() 
{
    const int num_iterations = 10000000;
    writeln("Estimated Pi: ", montecarlo_pi(num_iterations));
}
