if(MSVC AND HAVE_STD_MODULES)
  find_file(msvc_std_src NAMES std.ixx
  PATHS $ENV{VCToolsInstallDir}/modules
  NO_DEFAULT_PATH)

  if(msvc_std_src)

  set(msvc_std_ifc ${CMAKE_CURRENT_BINARY_DIR}/std.ifc)

  add_custom_target(msvc_std
    COMMAND ${CMAKE_CXX_COMPILER} /std:c++latest /EHsc /nologo /c ${msvc_std_src}
    VERBATIM
    BYPRODUCTS ${msvc_std_ifc}
  )

  cmake_path(CONVERT ${msvc_std_ifc} TO_NATIVE_PATH_LIST msvc_std_ifc)


  add_executable(msvc_core msvc_core.cpp)
  target_compile_options(msvc_core PRIVATE /reference ${msvc_std_ifc})
  add_dependencies(msvc_core msvc_std)

  add_test(NAME msvc_core COMMAND msvc_core)

  else()
    message(WARNING "Cannot find MSVC std.ixx, skipping import std example")
  endif()
endif()

add_executable(math_mod math.cpp)
# https://cmake.org/cmake/help/latest/command/target_sources.html#file-sets
target_sources(math_mod PUBLIC
FILE_SET my_math
TYPE CXX_MODULES
FILES math.ixx
)

add_test(NAME MathModule COMMAND math_mod)
