######################
# General parameters #
######################

# data set
dataset=../44.moses
# directory name of the experiment
exp_dir=mp_hc_recall_0.5_kfd_10

# K-fold cross validation (if 1, no cross-validation)
Kfd=10

# rand_seq=({1..2})
rand_seq=(1)

jobs=4

# number of candidate per moses execution
candidates=10

# To only experiment without fsm (to search an interesting experiment)
no_fsm=false

######################
# Learning parameter #
######################
scorer=prerec
perm_ratio=1.0
# ctemp=0.00001
ctemp=2
hardness=1
recall_min=0.5
evals=10000
noise=0.1
revisit=0

######################
# Diversity pressure #
######################
dpressure=0.1
dexp=1
dst=tanimoto

##########################
# Pre Feature selection  #
##########################
pfs_algo=inc  # or hc
conf_seq=(100)                  # for inc and simple
#nfeats_seq=({10..30..10})
nfeats_seq=(20)

##########################################
# Feature selection with MOSES parameter #
##########################################
prune=0
# fsm_nfeats_seq=({2..18..4})     # for inc and simple
fsm_hc_conf_seq=(1.0)           # for inc and simple
fsm_nfeats_seq=(1)                        # for hc
fsm_conf_seq=(-0.1 -1.0 -10.0)            # for hc
focus_seq=(all active)
#focus_seq=(all active incorrect ai)
# seed_seq=(none add init xmplr)
seed_seq=(init)
fsm_algo=inc # or hc
# smp_pbty_seq=($(seq 0.1 0.1 0.9))
smp_pbty_seq=(0.1)
fsm_scorer_seq=(mi)
# scorer_seq=(mi pre)
#smd_threshold=0.000001
inc_red_intensity=0.1
hc_evals=10000
hc_crossover_pop_size=120
hc_widen_search=0
hc_crossover=1
breadth_first=1
#####################
# Model combination #
#####################
model_combination_noise=0.3
complexity_amplifier=0.1
prerec_simple_precision=true
#prerec_simple_precision=false # my modificatoin
maj_vote=0.5                    # between 0 and 1
model_combination_min_recall=0.5
