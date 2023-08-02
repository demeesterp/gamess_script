#!/bin/bash
echo "------------------------------------------"
echo "Start executing molecules batch on $(date)"
echo "------------------------------------------"

# check if input directory exists
INPUTDIR='./input'
if [ ! -d "$INPUTDIR" ]; then
  echo "$INPUTDIR does not exist."
  echo "please create input directory named 'input' and put your input files there."
  exit
fi

# check if output directory exists
OUTPUTDIR='./output'
if [ ! -d "$OUTPUTDIR" ]; then
  echo "$OUTPUTDIR does not exist."
    echo "please create output directory named 'output'."
    exit
fi

inputfiles=$(ls $INPUTDIR)
for file in $inputfiles
do
    echo "copy file $file to gamess execution envrionment"
    cp -f $INPUTDIR/$file ./$file
    echo "Start executing $file on $(date)"
    rungms $file 0 8 >& $file.log
    cp -f *.log $OUTPUTDIR
    rm -f *.log
    rm -f $file
    echo "---------------------------------------"
done