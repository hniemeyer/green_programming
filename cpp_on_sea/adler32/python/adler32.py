def adler32(data):
    mod_adler = 65521
    a = 1
    b = 0

    for byte in data:
        a = (a + byte) % mod_adler
        b = (b + a) % mod_adler

    return (b << 16) | a

if __name__ == "__main__":
    data = bytes([1, 2, 3, 4, 5]) 
    checksum = adler32(data)
    print(checksum)
