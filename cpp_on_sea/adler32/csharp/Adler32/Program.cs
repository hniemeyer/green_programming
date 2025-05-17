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
        byte[] data = { 1, 2, 3, 4, 5 };
        uint checksum1 = ComputeChecksum(data);
        Console.WriteLine("Adler-32 Checksumme: " + checksum1);
    }
}
