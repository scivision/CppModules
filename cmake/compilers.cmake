if(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
# /std:c++20 or newer implicitly enables modules
# https://learn.microsoft.com/en-us/cpp/build/reference/experimental-module
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU" AND CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL 14.1)
  add_compile_options(-fmodules-ts)
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang" AND CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL 17)
# -std=c++20 or higher implicitly enables modules
# https://releases.llvm.org/17.0.1/tools/clang/docs/StandardCPlusPlusModules.html#how-to-enable-standard-c-modules
endif()

check_cxx_symbol_exists(__cpp_modules "" HAVE_CXX_MODULES)
# Clang 19 didn't have __cpp_modules
if(NOT CMAKE_CXX_COMPILER_ID STREQUAL "Clang" AND NOT HAVE_CXX_MODULES)
  message(FATAL_ERROR "${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION} does not support C++20 modules")
endif()

check_cxx_symbol_exists(__cpp_lib_modules "version" HAVE_STD_MODULES)
