#!/bin/bash
function create_file_xls {
for file in "$1"/*
do 
this_file="${file##*/}"
if [ -d "$file" ]
then
create_file_xls "$file"
else

name="${this_file%.[^.]*}" 
extension="${this_file##*.}"
data_of_change=$(date +%Y-%m-%d -r "$file")
size=$(wc -c <"$file" | awk '{print $1}')
size="$size"
duration=$(mediainfo --Inform="General;%Duration%" $file)
let "duration_sec=duration/1000" 
echo -e "$name \t $extension \t $data_of_change \t $size "B" \t $duration_sec" >> result.xls

fi
done
}
 
echo "Enter the name of the directory"
read div
create_file_xls "$div"
echo "End of the script"
