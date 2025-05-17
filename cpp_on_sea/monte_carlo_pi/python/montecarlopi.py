import random

def monte_carlo_pi(num_iterations):
    inside_circle = 0
    for _ in range(num_iterations):
        x = random.uniform(0, 1)
        y = random.uniform(0, 1)

        if x * x + y * y <= 1.0:
            inside_circle += 1

    return 4.0 * inside_circle / num_iterations

num_iterations = 10000000
pi_estimate = monte_carlo_pi(num_iterations)
print(f"Estimated Pi: {pi_estimate}")
