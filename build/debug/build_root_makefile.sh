#!/bin/bash
 
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
