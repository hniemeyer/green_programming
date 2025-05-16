# adler32_checksum.rb

# This Ruby script generates a specified number of random unsigned 8-bit integers
# and computes the Adler-32 checksum over the resulting data buffer using a manual implementation.

# Adler-32 parameters
MOD_ADLER = 65_521

# Function to compute Adler-32 checksum manually
# num_bytes - number of random bytes (0..255) to generate
# Returns the Adler-32 checksum as an Integer

def compute_adler32(num_bytes)
  a = 1
  b = 0
  rand_gen = Random.new

  # Generate the full data buffer
  data = rand_gen.bytes(num_bytes)

  # Process entire buffer in one loop
  data.each_byte do |byte|
    a = (a + byte) % MOD_ADLER
    b = (b + a) % MOD_ADLER
  end

  # Combine sums into final checksum
  (b << 16) | a
end

# Main execution block
if __FILE__ == $0
  # Default number of bytes: 50 million
  num_bytes = 50_000_000

  puts "Generating \#{num_bytes} random 8-bit unsigned integers and computing Adler-32 checksum..."

  checksum = compute_adler32(num_bytes)

  puts "\nAdler-32 checksum: \#{checksum}"

end
s