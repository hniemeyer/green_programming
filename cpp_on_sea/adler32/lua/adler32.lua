-- adler32_checksum.lua
-- Generates 50 million random bytes (0–255) and computes the Adler-32 checksum

local count = 50000000
local MOD_ADLER = 65521

local a = 1
local b = 0

math.randomseed(os.time() + 1)

for i = 1, count do
    local byte = math.random(0, 255)
    a = (a + byte) % MOD_ADLER
    b = (b + a) % MOD_ADLER
end

-- combine b and a into checksum: (b << 16) | a
local checksum = (b * 2^16) + a
print(string.format("Adler-32 checksum after %d random bytes: 0x%08X", count, checksum))