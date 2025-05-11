fn adler32(data: &[u8]) -> u32 {
    const MOD_ADLER: u32 = 65_521;

    // Initialize sums
    let mut a: u32 = 1;
    let mut b: u32 = 0;

    // Process each byte
    for &byte in data {
        a = (a + u32::from(byte)) % MOD_ADLER;
        b = (b + a) % MOD_ADLER;
    }

    // Combine into a single 32-bit checksum
    (b << 16) | a
}

fn main() {
    let data: Vec<u8> = rand::random_iter().take(50_000_000).collect();
    let checksum = adler32(&data);
    println!("Adler-32 checksum: {:#010x}", checksum);
}
