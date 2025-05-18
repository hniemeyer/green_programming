using System;
using System.Text;
using System.Linq;

public class Adler32
{
    private const uint MOD_ADLER = 65521;
    public static uint ComputeChecksumWithLinq(byte[] data)
    {
        var result = data.Aggregate((a: 1u, b: 0u), (acc, byteValue) =>
        {
            acc.a = (acc.a + byteValue) % MOD_ADLER;
            acc.b = (acc.b + acc.a) % MOD_ADLER;
            return acc;
        });

        return (result.b << 16) | result.a;
    }

    public static void Main()
    {
        const int N = 50_000_000;  // 50 million elements

        // Allocate a byte[] on the heap
        byte[] array = new byte[N];

        // Fill with random bytes
        Random rnd = new Random();  
        rnd.NextBytes(array);
        uint checksum1 = ComputeChecksumWithLinq(array);
        Console.WriteLine("Adler-32 Checksumme: " + checksum1);
    }
}
