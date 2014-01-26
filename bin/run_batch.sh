#!/usr/bin/env bash

SOURCE="$( dirname ${BASH_SOURCE[0]} )"
OUTFILE="$SOURCE/../outs/ids"
INFILE="/tmp/wikis_batch_for_holmes"

CLASSIFIER_JAR="$SOURCE/holmes-cli-0.6-SNAPSHOT.jar"
CLASSIFIER_OBJ="$SOURCE/2014.01.26.classifier"

# remove the temp file if exists
if [ -f $INFILE ]; then
	echo $INFILE " exists. Terminating !";
	exit 1;
fi

for arg in ${@:1}; do
	BASE=$(basename $arg);
	ID=${BASE%%.*};
	export OUTFILE=${OUTFILE}_${ID};
	zcat $arg >> $INFILE;
done
OUTFILE="${OUTFILE}.out";

echo $INFILE `wc -l $INFILE` lines;
echo to $OUTFILE
echo "time java -jar $CLASSIFIER_JAR Classify -t 14 -c $CLASSIFIER_OBJ $INFILE > $OUTFILE";
time java -jar $CLASSIFIER_JAR Classify -t 14 -c $CLASSIFIER_OBJ $INFILE > $OUTFILE;

rm $INFILE;
