cmake_minimum_required(VERSION 3.3)

include(GetGitRevisionDescription)

git_describe(GIT_VERSION --tags --candidates=1 --abbrev=0)

message(STATUS "Git Version: ${GIT_VERSION}")

#parse the version information into pieces.
string(REGEX REPLACE "^([0-9]+)\\..*" "\\1" LZX_VERSION_MAJOR "${GIT_VERSION}")
string(REGEX REPLACE "^[0-9]+\\.([0-9]+).*" "\\1" LZX_VERSION_MINOR "${GIT_VERSION}")
string(REGEX REPLACE "^[0-9]+\\.[0-9]+\\.([0-9]+).*" "\\1" LZX_VERSION_PATCH "${GIT_VERSION}")

set(PROJECT_VERSION "${LZX_VERSION_MAJOR}.${LZX_VERSION_MINOR}.${LZX_VERSION_PATCH}")
