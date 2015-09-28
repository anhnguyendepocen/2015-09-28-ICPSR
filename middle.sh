#This is a comment!
#Usage: middle.sh [filename] [argument to head]
# [argument to tail]
#This script expects to recieve the name of a file
#(that exists), a number of lines from the front, and a number
#of lines from the end of the front section.
#This script will print out the middle section of the file,
#as specified by the numbers you give it 
head -"$2" "$1" | tail -"$3"
