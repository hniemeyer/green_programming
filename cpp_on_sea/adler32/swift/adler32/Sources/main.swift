import Foundation

func adler32Checksum(data: [UInt8]) -> UInt32 {
    let modAdler: UInt32 = 65521
    var a: UInt32 = 1
    var b: UInt32 = 0

    for byte in data {
        a = (a + UInt32(byte)) % modAdler
        b = (b + a) % modAdler
    }

    return (b << 16) | a
}

// Generate or load 50 million bytes of data
let dataCount = 50_000_000
var byteArray = [UInt8]() 
byteArray.reserveCapacity(dataCount)
for _ in 0..<dataCount {
    byteArray.append(UInt8.random(in: 0...255))
}

// Compute Adler-32
let checksum = adler32Checksum(data: byteArray)
print(String(format: "Adler-32 Checksum: 0x%08X", checksum))