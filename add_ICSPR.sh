#This script changes the names of all of the given files to 
#have ICPSR before them.
for filename in $@
do
mv $filename ICPSR_$filename
done

