#This script outputs the number of lines in all of the files you give it
#it uses $@ to let you pass in as many files as you want
wc -l $@
