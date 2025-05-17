#include <stdio.h>
#include <stdlib.h>
#include <time.h>

double montecarlo_pi(const int num_interations)
{
    srand(time(NULL));

    int inside_circle = 0;
    for (int i = 0; i < num_interations; i++) 
    {
        const double x = (double)rand() / RAND_MAX;
        const double y = (double)rand() / RAND_MAX;

        if (x * x + y * y <= 1.0) 
        {
            inside_circle++;
        }
    }

    return 4.0 * inside_circle / (double)num_interations;
}

int main() 
{
    const int num_interations = 10000000;

    const double pi = montecarlo_pi(num_interations);
    printf("%f\n", pi);
}
