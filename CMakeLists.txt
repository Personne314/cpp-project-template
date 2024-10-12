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

cmake_minimum_required(VERSION 3.28.3)

# Definition of project main propreties.
# MUST be adapted to each project.
project(CppProjectTemplate LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(EXEC_NAME "main")
set(LIBRARIES m)
set(DEBUG_FLAGS -g -Wall -Wextra)
set(RELEASE_FLAGS -O3)



# Get all sources files of the project.
file(GLOB_RECURSE TESTS "test/*.cpp")
file(GLOB_RECURSE SOURCES "src/*.cpp" "src/*.h" "src/*.hpp")

# Exclude the file containing the main function for testing.
set(SOURCES_TESTS "")
foreach(SOURCE ${SOURCES})
    file(READ ${SOURCE} FILE_CONTENTS)
    if(NOT FILE_CONTENTS MATCHES "int[ \t\r\n]+main[ \t\r\n]*\\(")
        list(APPEND SOURCES_TESTS ${SOURCE})
    endif()
endforeach()




# Add the main executable, with Release and Debug mode.
if (NOT ${SOURCES} STREQUAL "") 
    add_executable(${EXEC_NAME} ${SOURCES} ${HEADERS} ${TEMPLATES})
    target_link_libraries(${EXEC_NAME} ${LIBRARIES})
    target_compile_options(${EXEC_NAME} PRIVATE
        $<$<CONFIG:Debug>:${DEBUG_FLAGS}> 
        $<$<CONFIG:Release>:${RELEASE_FLAGS}>               
    )
endif()

# Add tests only for Debug mode.
if(CMAKE_BUILD_TYPE STREQUAL "Debug")

    # Function to add an executable for tests.
    function(add_test_executable ARG1 ...)
        get_filename_component(TEST_NAME ${ARG1} NAME_WE)
        add_executable(${TEST_NAME} ${ARGV})
        target_compile_options(${TEST_NAME} PRIVATE ${DEBUG_FLAGS})
        target_link_libraries(${TEST_NAME} ${LIBRARIES})
        add_dependencies(build_tests ${TEST_NAME})
        add_custom_command(
            TARGET run_tests
            COMMAND ${CMAKE_COMMAND} -E echo "Running ${TEST_NAME}..."
            COMMAND $<TARGET_FILE:${TEST_NAME}>
            DEPENDS ${TEST_NAME}
        )
    endfunction()

    # Add custom targets to build and run all tests.
    add_custom_target(
        build_tests
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    )
    add_custom_target(
        run_tests
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    )

    # Add each testing executable.
    foreach(TEST_FILE ${TESTS})
        add_test_executable(${TEST_FILE} ${SOURCES_TESTS})
    endforeach()

endif()

# Add a rule to build the root Makefile.
add_custom_target(
    build_root_makefile
    COMMAND ./build_root_makefile.sh
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

add_custom_target(
    run 
    COMMAND ./${EXEC_NAME}
    DEPENDS ${EXEC_NAME}
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)