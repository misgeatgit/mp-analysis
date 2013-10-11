#!/bin/bash
#
# Evaluate diversity between all models of a given experiment

if [[ $# != 1 ]]; then
    echo "Error: wrong number of command parameters"
    echo "Usage: $0 SETTINGS_FILE"
    exit 1
fi

set -x
. $1

PROG_PATH=$(readlink -f "$0")
PROG_DIR=$(dirname "$PROG_PATH")
. $PROG_DIR/common.sh

bnd=$(basename $dataset)

for p in $(uniq_prefixes "$exp_dir/anal/" "_cnd_*_train.csv"); do
    CMD="/home/addis-ai/opencog_ocpkg/opencog/build/opencog/learning/moses/main/eval-diversity -u OUT --display-stats 1 --diversity-dst tanimoto"  #my modification(Misgana) changed value of -u from out to f280
    for cnd in $(seq 0 $(($candidates - 1))); do
        CMD+=" -i ${p}_cnd_${cnd}_train.csv"
    done
    CMD+=" -o $p.diversity"
    #echo "$CMD" #my modification(Misgana) commented it
    $CMD #my modification(Misgana) uncommented it
done | $PPAR
