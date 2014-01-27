#!/usr/bin/env bash

DIR="$( dirname ${BASH_SOURCE[0]} )/../"
: ${BATCH_SIZE:=20}
find "${DIR}dumps/" -iname "*.dump.gz" |sort | xargs -n $BATCH_SIZE "${DIR}bin/run_batch.sh";
