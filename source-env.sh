#!/bin/bash

# source ups products and larsoft version, considering the setup of gallery
source /afs/cern.ch/work/e/evilla/private/dune/dunesw/source-dune.sh

export DUNESW_VERSION=v09_85_00d00; # this is what Klaudia used to test the workflow
export DUNESW_QUALIFIER=e26:prof;
echo 'Setting up dunesw version' $DUNESW_VERSION', qualifier' $DUNESW_QUALIFIER '...'
setup -B dunesw $DUNESW_VERSION -q $DUNESW_QUALIFIER
echo 'Done!'

# now set up gallery
export GALLERY_VERSION=v1_20_03;
export GALLERY_QUALIFIER=e26:prof;
setup -B gallery $GALLERY_VERSION -q $GALLERY_QUALIFIER

# now cmake
setup -B cmake v3_9_2

# gcc    
echo "Setting up gcc 12..."
# source /cvmfs/sft.cern.ch/lcg/contrib/gcc/11/x86_64-centos7/setup.sh
# export PATH="/cvmfs/sft.cern.ch/lcg/releases/zlib/1.2.11-8af4c/x86_64-centos7-gcc11-opt//bin:$PATH"
# export LD_LIBRARY_PATH="/cvmfs/sft.cern.ch/lcg/releases/lzlib/1.2.11-8af4c/x86_64-centos7-gcc11-opt//lib:$LD_LIBRARY_PATH"
setup -B gcc v9_3_0
export LD_LIBRARY_PATH=/cvmfs//larsoft.opensciencegrid.org/products/gcc/v9_3_0/Linux64bit+3.10-2.17/lib:$LD_LIBRARY_PATH
# echo "Done!"