import subprocess

# binFile = open('Resort202105082205/Sports2.dat')
proc = subprocess.Popen(["tachtig", "data.bin"] )
output = proc.communicate()[0]
print(output)
# proc = subprocess.Popen(["xxd", "-p", "Resort202105082205/Sports2.dat"] )
# output = proc.communicate()[0]
# print(output)
