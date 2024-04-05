#!/bin/bash

# Script to run the python code to convert the artroot file to a root file

print_help() {
    echo "Usage: ./compileAndConvert.sh [options]"
    echo "Options:"
    echo "  -h, --help: print this help message"
    echo "  -i, --input-file: input artroot file"
    echo " --tag: tag to be used in the output file. Default is marley"
}

HOME_DIR=$(git rev-parse --show-toplevel)
CURRENT_DIR=$(pwd)
BUILD=false
tag="marley"
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
        --tag)
            tag="$2"
            shift
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

# source ups products and dunesw version
source source-env.sh

# run the converter
cd $HOME_DIR
command_to_run="python tps-MCtruth-converter.py -i $INPUT_FILE --tag marley"
echo "Running command: $command_to_run"
$command_to_run
cd $CURRENT_DIR; # go back to the original directory