#!/bin/bash

# files=$(find data -name '*.hea')
files=$(find data -regex '.*[0-9]\.hea$')
# files=$(find data -regex '.*/s[0-9]+\.hea')

# cleanup
rm -rf asc_data/*
mkdir -p asc_data

for file in $files
do
    filename=$(basename "$file" .hea)
    
    freq=$(head -n 1 "$file" | cut -d ' ' -f 3)
    
    echo "Record name: $filename, file: $file, Frequency: $freq"

    matlab -nodisplay -nodesktop -r "detection('$filename', $freq); quit;"

    wrann -r "data/$filename" -a qrs < "asc_data/$filename.asc"
    bxb -r "data/$filename" -a atr qrs -l eval1.txt eval2.txt
    sumstats eval1.txt eval2.txt > results.txt
done
