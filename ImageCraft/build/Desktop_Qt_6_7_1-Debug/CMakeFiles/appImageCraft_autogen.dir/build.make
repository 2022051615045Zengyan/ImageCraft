# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.29

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Produce verbose output by default.
VERBOSE = 1

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
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
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /run/media/root/study/qml/ImageCraft

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /run/media/root/study/qml/ImageCraft/build/Desktop_Qt_6_7_1-Debug

# Utility rule file for appImageCraft_autogen.

# Include any custom commands dependencies for this target.
include CMakeFiles/appImageCraft_autogen.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/appImageCraft_autogen.dir/progress.make

CMakeFiles/appImageCraft_autogen: appImageCraft_autogen/timestamp

appImageCraft_autogen/timestamp: /opt/Qt/6.7.1/gcc_64/./libexec/moc
appImageCraft_autogen/timestamp: CMakeFiles/appImageCraft_autogen.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/run/media/root/study/qml/ImageCraft/build/Desktop_Qt_6_7_1-Debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Automatic MOC and UIC for target appImageCraft"
	/usr/bin/cmake -E cmake_autogen /run/media/root/study/qml/ImageCraft/build/Desktop_Qt_6_7_1-Debug/CMakeFiles/appImageCraft_autogen.dir/AutogenInfo.json Debug
	/usr/bin/cmake -E touch /run/media/root/study/qml/ImageCraft/build/Desktop_Qt_6_7_1-Debug/appImageCraft_autogen/timestamp

appImageCraft_autogen: CMakeFiles/appImageCraft_autogen
appImageCraft_autogen: appImageCraft_autogen/timestamp
appImageCraft_autogen: CMakeFiles/appImageCraft_autogen.dir/build.make
.PHONY : appImageCraft_autogen

# Rule to build all files generated by this target.
CMakeFiles/appImageCraft_autogen.dir/build: appImageCraft_autogen
.PHONY : CMakeFiles/appImageCraft_autogen.dir/build

CMakeFiles/appImageCraft_autogen.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/appImageCraft_autogen.dir/cmake_clean.cmake
.PHONY : CMakeFiles/appImageCraft_autogen.dir/clean

CMakeFiles/appImageCraft_autogen.dir/depend:
	cd /run/media/root/study/qml/ImageCraft/build/Desktop_Qt_6_7_1-Debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /run/media/root/study/qml/ImageCraft /run/media/root/study/qml/ImageCraft /run/media/root/study/qml/ImageCraft/build/Desktop_Qt_6_7_1-Debug /run/media/root/study/qml/ImageCraft/build/Desktop_Qt_6_7_1-Debug /run/media/root/study/qml/ImageCraft/build/Desktop_Qt_6_7_1-Debug/CMakeFiles/appImageCraft_autogen.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/appImageCraft_autogen.dir/depend
