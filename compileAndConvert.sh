#!bin/bash

# Script to compile and execute rapidly the converter to flat root


print_help() {
    echo "Usage: ./compileAndConvert.sh [options]"
    echo "Options:"
    echo "  -h, --help: print this help message"
    echo "  -i, --input-file: input artroot file"
    echo "  [-b], [--build]: build the converter"
}

HOME_DIR=$(git rev-parse --show-toplevel)
CURRENT_DIR=$(pwd)
BUILD=false
INPUT_FILE=""

# parse the arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -h|--help)
            print_help
            exit 0
            ;;
        -i|--input-file)
            INPUT_FILE="$2"
            shift
            shift
            ;;
        -b|--build)
            BUILD=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            print_help
            exit 1
            ;;
    esac
done

# if no input file, stop execution
if [ -z "$INPUT_FILE" ]; then
    echo "No input file specified"
    print_help
    exit 1
fi


# compile the code
if [ -z "$BUILD" ]; then
    echo "Building the converter..."
    mkdir -p build
    cd $HOME_DIR/build
    cmake -DCMAKE_C_COMPILER=$(which gcc) -DCMAKE_CXX_COMPILER=$(which g++)  -DCMAKE_BUILD_TYPE=RelWithDebInfo ..
    make
    cd ..
fi

# source ups products and larsoft version, considering the setup of gallery
source /afs/cern.ch/work/e/evilla/private/dune/dunesw/source-dune.sh
source /afs/cern.ch/work/e/evilla/private/dune/dunesw/setup-v79.sh
source $HOME_DIR/demo-setup

# run the converter
./myconverter $INPUT_FILE

cd $CURRENT_DIR; # go back to the original directory
