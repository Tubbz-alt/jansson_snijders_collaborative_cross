#!/bin/bash

#===============================================#
# Join all demultiplexed fastq files
#===============================================#


# Setting up folders
homedir=/people/bris469/data/CC_diet_swap_newest
input=$homedir/raw_data
output=$homedir/join
rm -rf $output
mkdir $output


# Print the part of the read name that changes
cd $input
ls *R1* | cut -d_ -f1 > $output/readnames.txt
echo Head of readnames.txt: 
head $output/readnames.txt


parallel --jobs 4 '
#  echo {}
# Name fixing is important! This removes characters which would foul qiime.
  outputname="$(echo {1} | cut -d_ -f1 | sed s/[-_]/./g)"
  echo $outputname
  vsearch --fastq_mergepairs {1}_R1.fastq.gz \
    --reverse {1}_R2.fastq.gz \
    --fastqout {2}/${outputname}_merged.fastq \
    --fastq_minovlen 200 --fastq_maxdiffs 20
' :::: $output/readnames.txt ::: $output

cd $output
pigz *fastq
