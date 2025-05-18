import std.stdio;
import std.array;
import std.random;
import std.datetime : MonoTime;

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
    enum size_t N = 50_000_000; // 50 million elements

    // Allocate a ubyte[] on the heap
    ubyte[] array = new ubyte[N];

    // Seed the PRNG with the current time
    auto seed = 42;
    Random rng = Random(seed);

    // Fill the array
    foreach (i; 0 .. N)
    {
        array[i] = uniform!(ubyte)(rng);
    } 
    uint checksum = adler32(array);
    checksum.writeln;
}
