import java.util.Random;

public class MonteCarloPi {
  public static void main(String[] args) {
    final long iterations = 10_000_000L;
    long insideCircle = 0;
    Random random = new Random();

    for (long i = 0; i < iterations; i++) {
      double x = random.nextDouble();
      double y = random.nextDouble();
      if (x * x + y * y <= 1.0) {
        insideCircle++;
      }
    }

    double piEstimate = 4.0 * insideCircle / iterations;
    System.out.println("Estimated Pi = " + piEstimate);
  }
}