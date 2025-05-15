// adler32_checksum.ts
// Computes Adler-32 checksum for a randomly generated list of 50 million unsigned 8-bit integers

function generateRandomBytes(length: number): Uint8Array {
  const buffer = new Uint8Array(length);
  for (let i = 0; i < length; i++) {
    buffer[i] = Math.floor(Math.random() * 256);
  }
  return buffer;
}

function adler32(data: Uint8Array): number {
  const MOD_ADLER = 65521;
  let a = 1;
  let b = 0;
  for (let i = 0; i < data.length; i++) {
    a = (a + data[i]) % MOD_ADLER;
    b = (b + a) % MOD_ADLER;
  }
  return (b << 16) | a;
}

const BYTE_COUNT = 50_000_000;
console.log(`Generating ${BYTE_COUNT.toLocaleString()} random bytes...`);
const bytes = generateRandomBytes(BYTE_COUNT);
console.log(`Computing Adler-32 checksum...`);
const checksum = adler32(bytes);
console.log(`Adler-32 checksum = 0x${checksum.toString(16).padStart(8, "0")}`);