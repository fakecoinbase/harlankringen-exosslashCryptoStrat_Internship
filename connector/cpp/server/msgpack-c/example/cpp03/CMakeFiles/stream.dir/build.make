# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/harlan/ucsb/projects/exos_internship/CryptoStrat_Internship/connector/cpp/src/msgpack-c

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/harlan/ucsb/projects/exos_internship/CryptoStrat_Internship/connector/cpp/src/msgpack-c

# Include any dependencies generated for this target.
include example/cpp03/CMakeFiles/stream.dir/depend.make

# Include the progress variables for this target.
include example/cpp03/CMakeFiles/stream.dir/progress.make

# Include the compile flags for this target's objects.
include example/cpp03/CMakeFiles/stream.dir/flags.make

example/cpp03/CMakeFiles/stream.dir/stream.cpp.o: example/cpp03/CMakeFiles/stream.dir/flags.make
example/cpp03/CMakeFiles/stream.dir/stream.cpp.o: example/cpp03/stream.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/harlan/ucsb/projects/exos_internship/CryptoStrat_Internship/connector/cpp/src/msgpack-c/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object example/cpp03/CMakeFiles/stream.dir/stream.cpp.o"
	cd /home/harlan/ucsb/projects/exos_internship/CryptoStrat_Internship/connector/cpp/src/msgpack-c/example/cpp03 && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/stream.dir/stream.cpp.o -c /home/harlan/ucsb/projects/exos_internship/CryptoStrat_Internship/connector/cpp/src/msgpack-c/example/cpp03/stream.cpp

example/cpp03/CMakeFiles/stream.dir/stream.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/stream.dir/stream.cpp.i"
	cd /home/harlan/ucsb/projects/exos_internship/CryptoStrat_Internship/connector/cpp/src/msgpack-c/example/cpp03 && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/harlan/ucsb/projects/exos_internship/CryptoStrat_Internship/connector/cpp/src/msgpack-c/example/cpp03/stream.cpp > CMakeFiles/stream.dir/stream.cpp.i

example/cpp03/CMakeFiles/stream.dir/stream.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/stream.dir/stream.cpp.s"
	cd /home/harlan/ucsb/projects/exos_internship/CryptoStrat_Internship/connector/cpp/src/msgpack-c/example/cpp03 && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/harlan/ucsb/projects/exos_internship/CryptoStrat_Internship/connector/cpp/src/msgpack-c/example/cpp03/stream.cpp -o CMakeFiles/stream.dir/stream.cpp.s

example/cpp03/CMakeFiles/stream.dir/stream.cpp.o.requires:

.PHONY : example/cpp03/CMakeFiles/stream.dir/stream.cpp.o.requires

example/cpp03/CMakeFiles/stream.dir/stream.cpp.o.provides: example/cpp03/CMakeFiles/stream.dir/stream.cpp.o.requires
	$(MAKE) -f example/cpp03/CMakeFiles/stream.dir/build.make example/cpp03/CMakeFiles/stream.dir/stream.cpp.o.provides.build
.PHONY : example/cpp03/CMakeFiles/stream.dir/stream.cpp.o.provides

example/cpp03/CMakeFiles/stream.dir/stream.cpp.o.provides.build: example/cpp03/CMakeFiles/stream.dir/stream.cpp.o


# Object files for target stream
stream_OBJECTS = \
"CMakeFiles/stream.dir/stream.cpp.o"

# External object files for target stream
stream_EXTERNAL_OBJECTS =

example/cpp03/stream: example/cpp03/CMakeFiles/stream.dir/stream.cpp.o
example/cpp03/stream: example/cpp03/CMakeFiles/stream.dir/build.make
example/cpp03/stream: example/cpp03/CMakeFiles/stream.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/harlan/ucsb/projects/exos_internship/CryptoStrat_Internship/connector/cpp/src/msgpack-c/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable stream"
	cd /home/harlan/ucsb/projects/exos_internship/CryptoStrat_Internship/connector/cpp/src/msgpack-c/example/cpp03 && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/stream.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
example/cpp03/CMakeFiles/stream.dir/build: example/cpp03/stream

.PHONY : example/cpp03/CMakeFiles/stream.dir/build

example/cpp03/CMakeFiles/stream.dir/requires: example/cpp03/CMakeFiles/stream.dir/stream.cpp.o.requires

.PHONY : example/cpp03/CMakeFiles/stream.dir/requires

example/cpp03/CMakeFiles/stream.dir/clean:
	cd /home/harlan/ucsb/projects/exos_internship/CryptoStrat_Internship/connector/cpp/src/msgpack-c/example/cpp03 && $(CMAKE_COMMAND) -P CMakeFiles/stream.dir/cmake_clean.cmake
.PHONY : example/cpp03/CMakeFiles/stream.dir/clean

example/cpp03/CMakeFiles/stream.dir/depend:
	cd /home/harlan/ucsb/projects/exos_internship/CryptoStrat_Internship/connector/cpp/src/msgpack-c && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/harlan/ucsb/projects/exos_internship/CryptoStrat_Internship/connector/cpp/src/msgpack-c /home/harlan/ucsb/projects/exos_internship/CryptoStrat_Internship/connector/cpp/src/msgpack-c/example/cpp03 /home/harlan/ucsb/projects/exos_internship/CryptoStrat_Internship/connector/cpp/src/msgpack-c /home/harlan/ucsb/projects/exos_internship/CryptoStrat_Internship/connector/cpp/src/msgpack-c/example/cpp03 /home/harlan/ucsb/projects/exos_internship/CryptoStrat_Internship/connector/cpp/src/msgpack-c/example/cpp03/CMakeFiles/stream.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : example/cpp03/CMakeFiles/stream.dir/depend

