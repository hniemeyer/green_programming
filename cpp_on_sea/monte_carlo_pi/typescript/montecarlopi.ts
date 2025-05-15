// monte_carlo_pi.ts
// Calculates π using the Monte Carlo method with 10 million iterations

function estimatePi(iterations: number): number {
  let inside = 0;
  for (let i = 0; i < iterations; i++) {
    const x = Math.random();
    const y = Math.random();
    if (x * x + y * y <= 1) {
      inside++;
    }
  }
  return (inside / iterations) * 4;
}

const ITERATIONS = 10_000_000;
console.log(`Estimating π with ${ITERATIONS.toLocaleString()} iterations...`);
const piEstimate = estimatePi(ITERATIONS);
console.log(`Estimated π = ${piEstimate}`);