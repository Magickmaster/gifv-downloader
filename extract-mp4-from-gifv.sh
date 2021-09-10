#!/bin/bash
for file in *.gifv
do
    echo "Processing " $file
    line=$( grep '<meta property="og:video:secure_url"' $file )
    if [ -z "$line" ]
    then
        line=$( grep '<meta property="og:url"' $file )
        link=$( echo $line | cut -d '=' -f 3 | cut -c 2- | rev | cut -c 16- | rev )
        name=$( echo $file | rev | cut -c 2- | rev  )
    else
        link=$( echo $line | cut -d '=' -f 3 | cut -c 2- | rev | cut -c 5- | rev )
        name=$( echo $file | rev | cut -c 5- | rev ; echo "mp4" )
        name=$(echo $name | sed -r 's/\s+//g')
    fi
    wget -q $link -O $name
    echo "Downloaded " $name
    echo "#"
done