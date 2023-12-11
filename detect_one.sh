#!/bin/bash

record_id="$1"

file=$(find data -name "$record_id.hea" -print -quit)

freq=$(head -n 1 "$file" | cut -d ' ' -f 3)
filename=$(basename "$file" .hea)

# cleanup
rm -rf asc_data/*
mkdir -p asc_data

echo "Record name: $filename, file: $file, Frequency: $freq"

matlab -nodisplay -nodesktop -r "detection('$filename', $freq); quit;"

wrann -r "data/$filename" -a qrs < "asc_data/$filename.asc"
bxb -r "data/$filename" -a atr qrs -l eval1.txt eval2.txt
sumstats eval1.txt eval2.txt > results.txt
