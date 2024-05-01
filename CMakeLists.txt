cmake_minimum_required(VERSION 3.28...3.30)

project(CppModules LANGUAGES CXX)

enable_testing()

include(CheckCXXSymbolExists)


if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 23)
endif()

include(cmake/compilers.cmake)

add_subdirectory(src)

file(GENERATE OUTPUT .gitignore CONTENT "*")
