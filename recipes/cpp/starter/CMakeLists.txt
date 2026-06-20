cmake_minimum_required(VERSION 3.25)

project(
  starter_project
  VERSION 0.1.0
  DESCRIPTION "<description>"
  LANGUAGES CXX
)

include(CTest)
include(cmake/ProjectOptions.cmake)
include(cmake/CompilerWarnings.cmake)
include(cmake/Sanitizers.cmake)
include(cmake/Coverage.cmake)
include(cmake/StaticAnalysis.cmake)

option(STARTER_PROJECT_BUILD_TESTS "Build test targets" ON)
option(STARTER_PROJECT_BUILD_EXAMPLES "Build examples" ON)
option(STARTER_PROJECT_ENABLE_WARNINGS "Enable compiler warnings" ON)
option(STARTER_PROJECT_WARNINGS_AS_ERRORS "Treat warnings as errors" ON)
option(STARTER_PROJECT_ENABLE_SANITIZERS "Enable sanitizers" OFF)
option(STARTER_PROJECT_ENABLE_COVERAGE "Enable coverage" OFF)
option(STARTER_PROJECT_ENABLE_CLANG_TIDY "Enable clang-tidy" OFF)
option(STARTER_PROJECT_ENABLE_CPPCHECK "Enable cppcheck" OFF)
option(STARTER_PROJECT_ENABLE_IWYU "Enable include-what-you-use" OFF)

add_library(project_options INTERFACE)
target_compile_features(project_options INTERFACE cxx_std_20)
target_include_directories(
  project_options
  INTERFACE
    "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
)

add_library(project_warnings INTERFACE)
if(STARTER_PROJECT_ENABLE_WARNINGS)
  configure_project_warnings(project_warnings STARTER_PROJECT_WARNINGS_AS_ERRORS)
endif()

if(STARTER_PROJECT_ENABLE_SANITIZERS)
  enable_project_sanitizers(project_options)
endif()

if(STARTER_PROJECT_ENABLE_COVERAGE)
  enable_project_coverage(project_options)
endif()

if(STARTER_PROJECT_ENABLE_CLANG_TIDY OR STARTER_PROJECT_ENABLE_CPPCHECK OR STARTER_PROJECT_ENABLE_IWYU)
  enable_project_static_analysis()
endif()

add_custom_target(format COMMAND ${CMAKE_COMMAND} -P "${PROJECT_SOURCE_DIR}/cmake/Format.cmake")
add_custom_target(
  format-check
  COMMAND ${CMAKE_COMMAND} -DFORMAT_CHECK=ON -P "${PROJECT_SOURCE_DIR}/cmake/Format.cmake")

if(STARTER_PROJECT_BUILD_TESTS AND BUILD_TESTING)
  add_subdirectory(tests)
endif()

if(STARTER_PROJECT_BUILD_EXAMPLES)
  add_subdirectory(examples)
endif()
