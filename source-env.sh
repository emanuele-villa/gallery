#!/bin/bash

# source ups products and larsoft version, considering the setup of gallery
echo 'Running setup-dune.sh...'
source /cvmfs/dune.opensciencegrid.org/products/dune/setup_dune.sh

export DUNESW_VERSION=v09_85_00d00; 
export DUNESW_QUALIFIER=e26:prof;
echo 'Setting up dunesw version' $DUNESW_VERSION', qualifier' $DUNESW_QUALIFIER '...'
setup 1
dunesw $DUNESW_VERSION -q $DUNESW_QUALIFIER
echo 'Done! dunesw sets up also gallery at the same time'

# no need for this if using python
# # now cmake
# setup -B cmake v3_25_2

# # now a gcc version
# echo "Setting up gcc..."
# setup -B gcc v9_3_0
# export LD_LIBRARY_PATH=/cvmfs//larsoft.opensciencegrid.org/products/gcc/v9_3_0/Linux64bit+3.10-2.17/lib:$LD_LIBRARY_PATH
# echo "Done!"