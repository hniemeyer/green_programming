use rand::Rng;

fn main() {
    // Parse number of iterations from command line or default
    let iterations: u64 = 10_000_000; // Default to 10 million iterations

    let pi_estimate = monte_carlo_pi(iterations);
    println!(
        "Estimated Pi = {} (using {} iterations)",
        pi_estimate, iterations
    );
}

fn monte_carlo_pi(iterations: u64) -> f64 {
    let mut rng = rand::rng();
    let mut inside_circle = 0;

    for _ in 0..iterations {
        let x: f64 = rng.random_range(0.0..1.0); // uniform in [0, 1)
        let y: f64 = rng.random_range(0.0..1.0);
        if x * x + y * y <= 1.0 {
            inside_circle += 1;
        }
    }

    // The ratio inside_circle/iterations approximates area of quarter circle
    4.0 * (inside_circle as f64) / (iterations as f64)
}
