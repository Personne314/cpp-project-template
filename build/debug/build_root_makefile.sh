#!/bin/bash

# MIT License

# Copyright (c) 2024 [Louis FOULOU]

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# This script create a makefile in the root of the project allowing you to call 
# CMake Makefile build tragets from there, plus somme command allowing you to 
# switch between Release mode and Debug mode and executing tests.
{

    # Read the CMake Makefile and build the root Makefile according to it's rules.
    if [ -f "Makefile" ]; then
        while IFS= read -r line; do
            if echo "$line" | grep -qE '^[a-zA-Z0-9\-_]+:'; then
                target=$(echo "$line" | sed 's/:.*//') 
                echo "$target:"
                echo "	make -s -C build/debug $target"
                echo ""
            fi
        done < "Makefile"
    else
        echo "CMake Makefile couldn't be found"
    fi

    #  Add rules to switch between Release and Debug.
    echo "Release:"
	echo "	@cmake -S . -B build/release -DCMAKE_BUILD_TYPE=Release"
    echo "	@make -s -C build/release build_root_makefile"
	echo "	@echo \"[Release Mode]\""
    echo ""
    echo "Debug:"
	echo "	@cmake -S . -B build/debug -DCMAKE_BUILD_TYPE=Debug"
    echo "	@make -s -C build/debug build_root_makefile"
	echo "	@echo \"[Debug Mode]\""
    echo ""
    echo "update:"
	echo "	@cmake -S . -B build/debug -DCMAKE_BUILD_TYPE=Debug"
    echo "	@make -s -C build/debug build_root_makefile"
	echo "	@echo \"[Debug Mode]\""
    echo ""
    echo "Info:"
	echo "	@echo \"[Debug Mode]\""
    echo ""

} > ../../Makefile

echo "Successfully created root Makefile"
