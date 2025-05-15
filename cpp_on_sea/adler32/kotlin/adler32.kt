import java.util.Random

fun main() {
    // Number of random bytes to generate
    val count = 50_000_000

    // Adler-32 parameters
    val MOD_ADLER = 65521
    var a = 1
    var b = 0

    // Initialize random generator
    val random = Random()

    // Generate and store random bytes
    val data = IntArray(count) { random.nextInt(256) }

    // Compute Adler-32 checksum
    for (byteValue in data) {
        a = (a + byteValue) % MOD_ADLER
        b = (b + a) % MOD_ADLER
    }

    // Combine sums into checksum
    val checksum = (b shl 16) or a
    println("Adler-32 checksum = $checksum")
}