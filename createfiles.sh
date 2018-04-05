# Thedoore Bieber
# Distributed Systems
# Project 2

# create 5 random files with size 1 to 10 mb
filesize=1000000
for i in {1..10}
	do
		base64 /dev/urandom | head -c $((filesize*i)) > testFile$i
	done
# generate 10mb file to test throughput
base64 /dev/urandom | head -c $((10000000)) > throughputTest