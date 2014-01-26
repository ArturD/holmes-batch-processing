#!/usr/bin/env bash

DIR="$( dirname ${BASH_SOURCE[0]} )/../"

find "${DIR}dumps/" | xargs -n 20 "${DIR}bin/run_batch.sh";
