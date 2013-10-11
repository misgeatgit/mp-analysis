#!/bin/bash
#
# Evaluate all models obtained during the experiment

if [[ $# != 1 ]]; then
    echo "Error: wrong number of command parameters"
    echo "Usage: $0 SETTINGS_FILE"
    exit 1
fi

. $1

PROG_PATH=$(readlink -f "$0")
PROG_DIR=$(dirname "$PROG_PATH")
. $PROG_DIR/common.sh

#set -u                       # error on unassigned variables
set -x                          # debug

# Evaluate each combo program
bnd=$(basename $dataset)

samples="train"
if [[ $Kfd > 1 ]]; then
    samples+=" test"
fi

for fd in $(seq 1 $Kfd); do
    for cfile in $exp_dir/anal/fd_${fd}to${Kfd}*.combo; do
        for smp in $samples; do
            ifile="$exp_dir/data/${bnd}.${smp}_${fd}to${Kfd}"
            
            ofile=$(chg_ext $(ibe "$cfile" _$smp) csv)            
            CMD=" /home/addis-ai/opencog_ocpkg/opencog/build/opencog/comboreduct/main/eval-table -i $ifile -C $cfile -o $ofile  -u OUT" #my modification(Misgana) changed value of -u from out to f280 ,delete --labels 1 option
            
            #echo "$CMD" ##my modification(Misgana) commented it
            $CMD ##my modification(Misgana) added it
        done
    done
done | $PPAR
