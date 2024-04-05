#!/bin/bash

# Script to compile and execute rapidly the converter to flat root


print_help() {
    echo "Usage: ./compileAndConvert.sh [options]"
    echo "Options:"
    echo "  -h, --help: print this help message"
    echo "  -i, --input-file: input artroot file"
    echo "  [-r], [--run]: run demo.py"
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

# source ups products and larsoft version, considering the setup of gallery
source source-env.sh

# run the converter
cd $HOME_DIR

echo " "
# echo "Running python-demo.py..."
# python python-demo.py $INPUT_FILE
# exporting the matplotlib path
# export PYTHONPATH=/afs/cern.ch/user/e/evilla/private/matplotlib/lib/python3.10/site-packages/:$PYTHONPATH

echo "Running jake-python.py..."
python jake-python.py -i $INPUT_FILE

cd $CURRENT_DIR; # go back to the original directory
