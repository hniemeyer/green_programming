defmodule MonteCarloPi do
  @moduledoc """
  Estimate the value of π (pi) using the Monte Carlo method.

  The idea:
  - Randomly sample points (x, y) in the unit square [0, 1] × [0, 1].
  - Count how many fall within the quarter-circle of radius 1: x^2 + y^2 ≤ 1.
  - The ratio of points inside the circle to total points approximates π/4.
  - Multiply by 4 to get the estimate for π.
  """

  @doc """
  Run the Monte Carlo simulation with the given number of iterations.
  Returns the estimated value of π.
  """
  def estimate_pi(iterations) when is_integer(iterations) and iterations > 0 do
    # Seed the random number generator for reproducibility
    :rand.seed(:exsp, {1234, 5678, 9012})

    inside_count =
      1..iterations
      |> Enum.reduce(0, fn _, acc ->
        x = :rand.uniform()
        y = :rand.uniform()
        if x * x + y * y <= 1.0, do: acc + 1, else: acc
      end)

    4.0 * inside_count / iterations
  end
end

defmodule Main do
  def main do
    iterations = 10_000_000

    IO.puts("Running Monte Carlo π estimation with #{iterations} iterations...")

    pi_estimate = MonteCarloPi.estimate_pi(iterations)

    IO.puts("Estimated π = #{pi_estimate}")
  end
end

Main.main()
