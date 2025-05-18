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
        byte[] data = { 1, 2, 3, 4, 5 };
        uint checksum1 = ComputeChecksumWithLinq(data);
        Console.WriteLine("Adler-32 Checksumme: " + checksum1);
    }
}
