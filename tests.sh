# Thedoore Bieber
# Distributed Systems
# Project 2

# initialize by creating local files
./removeFiles.sh
./createfiles.sh
# measure connection and teardown time
ctTotalTime=0
# rather than timing it in the c program, i can connect with a bad password and it will teardown the connection
# do that 100 times
for i in {1..20}
do
	# measure the first time.
	t1=$(date +%s%3N)
	# run client and redirect the output message to a file
	./client 18.219.163.32 a b ls > expOut
	# measure the second time
	t2=$(date +%s%3N)
	# calculate the time used
	timeUse=$((t2-t1))
	# add to total time
	ctTotalTime=$((ctTotalTime+timeUse))
	# print out the time used
	echo $timeUse " milliseconds"
done
# print the total time used and the average time
echo "total connection - tear down time is " $ctTotalTime " milliseconds"
echo "average connection - tear down time is " $((ctTotalTime/20)) " milliseconds"

# calculate the throughput
tpTotalTime=0
# print the size of the file
filesize=$(du -sb tpTest | cut -f1)
echo "Size of tpTest is $filesize bytes"
# Use cat command to get content for a 10MB file 20 times
for i in {1..10}
do
	# measure the first time
	t1=$(date +%s%3N)
	# measure the second time
	./client 52.88.191.178 a a cat tpTest > expOut
	# measure the second time
	t2=$(date +%s%3N)
	# calculate the time used
	timeUse=$((t2-t1))
	# add to total time
	tpTotalTime=$((tpTotalTime+timeUse))
	echo $timeUse " milliseconds"
	rm expOut
done
# print the total time used, the average time and the throughput
echo "total transfer time is " $tpTotalTime " milliseconds"
echo "average transfer time is " $((tpTotalTime/10)) " milliseconds"
echo "througput calculated is " $((filesize*8*10/(tpTotalTime/1000))) " bits/second"	

# get data to plot transfer size - time plot
# use cat command to get content for 10 files with size from 1MB to 10MB
# the time required to get the data is measured
# this is for connecting to the Amazon EC2 ubuntu instance
for i in {1..10}
do
	tmpTotalTime=0
	# print the size of the file
	filename=testFile$i
	filesize=$(du -sb $filename | cut -f1)
	echo "Size of $filename is $filesize bytes"
	for j in {1..10}
	do
		# measure the first time
		t1=$(date +%s%3N)
		# run client and redirect the output message to a file
		./client 52.88.191.178 a a cat testFile$i > expOut
		# measure the second time
		t2=$(date +%s%3N)
		# calculate the time used
		timeUse=$((t2-t1))
		tmpTotalTime=$((tmpTotalTime+timeUse))
		echo $timeUse " milliseconds"
		rm expOut		
	done
	echo "total transfer time is " $tmpTotalTime " milliseconds"
	echo "average transfer time is " $((tmpTotalTime/10)) " milliseconds"	
done

# get data to plot transfer size - time plot
# use cat command to get content for 10 files with size from 1MB to 10MB
# the time required to get the data is measured
# this is for connecting to local server
for i in {1..10}
do
	tmpTotalTime=0
	# print the size of the file
	filename=testFile$i
	filesize=$(du -sb $filename | cut -f1)
	echo "Size of $filename is $filesize bytes"
	for j in {1..10}
	do
		# measure the first time
		t1=$(date +%s%3N)
		# run client and redirect the output message to a file
		./client localhost a a cat testFile$i > expOut
		# measure the second time
		t2=$(date +%s%3N)
		# calculate the time used
		timeUse=$((t2-t1))
		tmpTotalTime=$((tmpTotalTime+timeUse))
		echo $timeUse " milliseconds"
		rm expOut		
	done
	echo "total transfer time is " $tmpTotalTime " milliseconds"
	echo "average transfer time is " $((tmpTotalTime/10)) " milliseconds"	
done


./removeFile.sh