import Foundation

func adler32Checksum(data: Data) -> UInt32 {
    let modAdler: UInt32 = 65521
    var a: UInt32 = 1
    var b: UInt32 = 0

    data.withUnsafeBytes { (rawBuffer: UnsafeRawBufferPointer) in
        let buffer = rawBuffer.bindMemory(to: UInt8.self)
        for byte in buffer {
            a = (a &+ UInt32(byte)) % modAdler
            b = (b &+ a) % modAdler
        }
    }

    return (b << 16) | a
}

// Generate 50 million random bytes efficiently as Data
let dataCount = 50_000_000
let data = Data((0..<dataCount).map { _ in UInt8.random(in: 0...255) })

// Compute Adler-32
let checksum = adler32Checksum(data: data)
print(String(format: "Adler32 Checksum: 0x%08X", checksum))