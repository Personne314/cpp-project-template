# C++ Project Template

This project is a basic CMake template created to serve as a starting point for my C++ projects. Please note that I have only a little knowledge of CMake (I've started making this template just a few hours after discovering CMake) and that there are surely better ways to create build environments, but I will try to improve this template over time.

## Setup

To setup the project, please update these lines at the begining of the CMakeLists.txt file to match your current project :
```
# Definition of project main propreties.
# MUST be adapted to each project.
project(CppProjectTemplate LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(EXEC_NAME "main")
set(LIBRARIES m)
set(DEBUG_FLAGS -g -Wall -Wextra)
set(RELEASE_FLAGS -O3)
```
Then, run :
```./init.sh```

Your project environment is now ready.

## Structure

The structure of this project template is : 

```
root
  ├── build
  │     ├── debug
  |     |     ├── build_root_makefile.sh
  |     |     ├── Makefile
  |     |     ├── ...
  |     |
  │     ├── release
  |     |     ├── build_root_makefile.sh
  |     |     ├── Makefile
  |     |     ├── ...
  |
  ├── src
  ├── test
  │     ├── release
  │     ├── debug
  │     ├── ...
  |     |
  ├── resources
  ├── CMakeLists.txt
  ├── Makefile
  |
```

Here are the content of the root folder :
- build contains a release and a debug folder. These folders are CMake build folders used for Release and Debug mode and contains CMake files such as the Makefile files. It also contains build_root_makefile.sh, wich are used to generate the root Makefile.
- scr is where you should put your source files (.cpp, .h, .hpp, ...).
- test is where you should put the source code of your test executables.
- resources is a folder where you should put resoucres needed by your executable. These files are automatically synchronized in the build/release and build/debug, so the last version of your resources files will always be next to your executable before it's executed. The content of the resources/release and resources/debug are only synchronized in the corresponding build folder.
- CMakeLists.txt is the project environment description, it should be modified before doing anything (especially before using ./init.sh).
- Makefile is a generated file used to run all projects command from root. It is automatically updated depending the current building mode (Release or Debug).

## Commands

This environment automatically generate a Makefile at the root of the project containing the same rules that the CMake Makefile in the build folder, plus some extra rules.

```
# Build all executables
make all

# Build and run the main executable.
make run

# Build and run all test executables.
make run_tests

# Build all test executables.
make build_tests

# Clean the build folder.
make clean

# Update the project environment. Use this when CMakeLists.txt is modified. 
make update

# Build the root Makefile. You should never need this because this Makefile is automatically updated, and if you loose it, well you won'tbe able to use this rule anyway.
make build_root_makefile

# Switch to Release mode. This also reinitialize the project environment.
make Release

# Switch to Debug mode. This also reinitialize the project environment.
make Debug

# Indicate the current building mode.
make Info
```

You can add to this rules all the executables default building rules.
