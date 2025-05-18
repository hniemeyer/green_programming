using System;
using System.Text;
using System.Linq;

public class Adler32
{
    private const uint MOD_ADLER = 65521;

    public static uint ComputeChecksum(byte[] data)
    {
        uint a = 1, b = 0;

        foreach (byte byteValue in data)
        {
            a = (a + byteValue) % MOD_ADLER;
            b = (b + a) % MOD_ADLER;
        }

        return (b << 16) | a;
    }

    public static void Main()
    {
        const int N = 50_000_000;  // 50 million elements

        // Allocate a byte[] on the heap
        byte[] array = new byte[N];

        // Fill with random bytes
        Random rnd = new Random();  
        rnd.NextBytes(array);
        uint checksum1 = ComputeChecksum(array);
        Console.WriteLine("Adler-32 Checksumme: " + checksum1);
    }
}
