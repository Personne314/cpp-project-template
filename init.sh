#!/bin/bash

# Call this to initialize the project environment.
cd build/release
cmake -S ../.. -B . -DCMAKE_BUILD_TYPE=Release
./build_root_makefile.sh
echo "Environment sucessfully initialised"
echo "[Release Mode]"
rm -f ../../init.sh
