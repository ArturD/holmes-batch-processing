#!/usr/bin/env bash

DIR="$( dirname ${BASH_SOURCE[0]} )/../"
OUTS_DIR="${DIR}outs"
SQL_DIR="${DIR}sql"
PYTHON="/usr/bin/env python"

for i in `ls ${OUTS_DIR}`; do 
	IN_FILE=$(basename $i)
	IN_PATH="$OUTS_DIR/${i}"
	OUT_PATH="${SQL_DIR}/${IN_FILE%%.*}.sql.gz"
	echo "starting $IN_PATH > $OUT_PATH"
	$PYTHON "${DIR}bin/gen_inserts.py" < $IN_PATH | gzip > $OUT_PATH
done

