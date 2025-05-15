fun main() {
    // Number of random points to generate
    val iterations = 10_000_000L
    var insideCircle = 0L

    // Random number generator
    val random = java.util.Random()

    // Monte Carlo simulation
    for (i in 1..iterations) {
        val x = random.nextDouble()
        val y = random.nextDouble()
        if (x * x + y * y <= 1.0) {
            insideCircle++
        }
    }

    // Estimate of Pi
    val piEstimate = 4.0 * insideCircle / iterations
    println("Estimated Pi = $piEstimate")
}