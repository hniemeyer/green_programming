import Foundation

func estimatePi(iterations: Int) {
    var insideCircle = 0
    for _ in 0..<iterations {
        // Generate random x, y in [-1, 1]
        let x = Double.random(in: -1...1)
        let y = Double.random(in: -1...1)
        if x*x + y*y <= 1 {
            insideCircle += 1
        }
    }
    // Ratio of points inside circle to total times 4 gives Pi
    let piEstimate = 4.0 * Double(insideCircle) / Double(iterations)
    print("Estimated Pi (\(iterations) iterations): \(piEstimate)")
}

// Run the Monte Carlo estimation
let monteCarloIterations = 10_000_000
estimatePi(iterations: monteCarloIterations)