#!/bin/bash

# Call this to initialize the project environment.
cd build/debug
cmake -S ../.. -B . -DCMAKE_BUILD_TYPE=Debug
./build_root_makefile.sh
echo "Environment sucessfully initialized"
echo "[Debug Mode]"
