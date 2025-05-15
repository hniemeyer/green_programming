import java.util.Random;

public class Adler32Checksum {
  public static void main(String[] args) {
    final int count = 50_000_000;
    final int MOD_ADLER = 65521;
    int a = 1;
    int b = 0;

    Random random = new Random();
    int[] data = new int[count];
    for (int i = 0; i < count; i++) {
      data[i] = random.nextInt(256);
    }

    for (int byteValue : data) {
      a = (a + byteValue) % MOD_ADLER;
      b = (b + a) % MOD_ADLER;
    }

    int checksum = (b << 16) | a;
    System.out.println("Adler-32 checksum = " + checksum);
  }
}