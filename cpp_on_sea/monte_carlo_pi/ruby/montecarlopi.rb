# monte_carlo_pi.rb

# This Ruby script estimates the value of Pi using the Monte Carlo method
# with a default of 10 million iterations.

# Function to perform the Monte Carlo simulation
# iterations - number of random (x, y) points to generate
# Returns the estimated value of Pi

def estimate_pi(iterations)
  inside = 0

  iterations.times do
    x = rand
    y = rand
    inside += 1 if x * x + y * y <= 1.0
  end

  4.0 * inside / iterations
end

# Main execution block
if __FILE__ == $0
  # Default number of iterations: 10 million
  iterations = 10_000_000

  puts "Estimating Pi using Monte Carlo with \#{iterations} iterations..."

  pi_estimate = estimate_pi(iterations)

  puts "\nEstimated Pi: \#{pi_estimate}"
end
