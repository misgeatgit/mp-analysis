#!/bin/bash
#
# Analyze a series of experiments on biological data. In terms of
# score and diversity.

#set -u
set -x

if [[ $# != 1 ]]; then
    echo "Error: wrong number of command parameters"
    echo "Usage: $0 SETTINGS_FILE"
    exit 1
fi

. $1

PROG_PATH=$(readlink -f "$0")
PROG_DIR=$(dirname "$PROG_PATH")
#echo "PROGRAM DIR "$PROG_DIR 	#my modification
. $PROG_DIR/common.sh


mkdir $exp_dir/anal

# Parse all moses output files
echo "PARSING ALL MOSES OUTPUT FILES..."  #my modification
for mfile in $exp_dir/res/*.moses; do
    #echo "$PROG_DIR/parse_moses_output.sh $mfile $exp_dir/anal" # my modifcation (Misgana) commented it
    $PROG_DIR/parse_moses_output.sh $mfile $exp_dir/anal #my modification (Misgana) add it
done | $PPAR

# Eval the output of all candidates for train and test
echo "EVALUATING THE OUTPUT OF ALL CANDIDATE FOR TRAIN AND TEST..."  #my modification
$PROG_DIR/eval_all_moses_output.sh $1

# Eval the likelihood all candidates
echo "EVALUATING THE LIKELIHOOD OF ALL CANDIDATES..."  #my modification
$PROG_DIR/eval_likelihoods.sh $1

# Combine all models (produce files ending by _combined.csv)
echo "COMBINING ALL MODELS..."  #my modification
$PROG_DIR/combine_models.sh $1

# Append all folded tests
echo "APPENDING ALL FOLDER TESTS..."  #my modification
$PROG_DIR/append_test_fold.sh $1

# Eval all outputs and sum them up in stats files, .precision and
# .recall files for combined models
echo "SUMMING ALL THE EVALUATION OUTPUTS..."  #my modification
$PROG_DIR/eval_train_test_mean_score.sh $1

# Eval the diversity of the top 10 candidates for each experiment
echo "EVALUATING THE DIVERSITY OF THE TOP 10 CNDIDATES..."  #my modification
$PROG_DIR/eval_diversity.sh $1

# Eval complexity of the top 10 candidates for each experiment
echo "EVALUATING THE COMPLEXITY OF THE TOP 10 CANDIDATES FOR EACH EXPERIMENT..."  #my modification
$PROG_DIR/eval_complexity_stats.sh $1

# Average folded stats
echo "AVERAGING FOLDED STATS..."  #my modification
$PROG_DIR/average_folded_stats.sh $1

# Create CSV file with the results of all experiments already folded
echo "CREATING CSV FILE OF ALL THE RESULTS OF EXPERIMENTS FOLDED..."  #my modification
$PROG_DIR/gather_scores_diversities_complexities_NEW.sh $1 > $exp_dir/results.csv
echo "###DONE ANALAYSING####"
