find_program(CLANG_FORMAT_EXE NAMES clang-format)
if(NOT CLANG_FORMAT_EXE)
  message(FATAL_ERROR "clang-format is required for format targets.")
endif()

file(
  GLOB_RECURSE
  FORMAT_FILES
  LIST_DIRECTORIES false
  "${CMAKE_CURRENT_LIST_DIR}/../include/*.h"
  "${CMAKE_CURRENT_LIST_DIR}/../include/*.hpp"
  "${CMAKE_CURRENT_LIST_DIR}/../src/*.cpp"
  "${CMAKE_CURRENT_LIST_DIR}/../tests/*.cpp"
  "${CMAKE_CURRENT_LIST_DIR}/../examples/*.cpp")

if(NOT FORMAT_FILES)
  message(STATUS "No C++ files found for clang-format.")
  return()
endif()

if(FORMAT_CHECK)
  execute_process(
    COMMAND "${CLANG_FORMAT_EXE}" --dry-run --Werror ${FORMAT_FILES}
    COMMAND_ERROR_IS_FATAL ANY)
else()
  execute_process(
    COMMAND "${CLANG_FORMAT_EXE}" -i ${FORMAT_FILES}
    COMMAND_ERROR_IS_FATAL ANY)
endif()
