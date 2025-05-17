import std.stdio;
import std.array;

uint adler32(const ubyte[] data) 
{
    const uint mod_adler = 65521;
    uint a = 1, b = 0;

    foreach (byteValue; data) 
    {
        a = (a + byteValue) % mod_adler;
        b = (b + a) % mod_adler;
    }

    return (b << 16) | a;
}

void main() 
{
    ubyte[] data = [1, 2, 3, 4, 5]; 
    uint checksum = adler32(data);
    checksum.writeln;
}
