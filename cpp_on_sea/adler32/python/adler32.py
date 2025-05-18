import os

def adler32(data):
    mod_adler = 65521
    a = 1
    b = 0

    for byte in data:
        a = (a + byte) % mod_adler
        b = (b + a) % mod_adler

    return (b << 16) | a

if __name__ == "__main__":
    
    # os.urandom returns a bytes object of length N, you can wrap it in bytearray if you need mutability:
    arr = bytearray(os.urandom(50_000_000))
    checksum = adler32(arr)
    print(checksum)
