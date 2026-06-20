include_guard(GLOBAL)

function(enable_project_static_analysis)
  if(STARTER_PROJECT_ENABLE_CLANG_TIDY)
    find_program(CLANG_TIDY_EXE NAMES clang-tidy)
    if(CLANG_TIDY_EXE)
      set(CMAKE_CXX_CLANG_TIDY
          "${CLANG_TIDY_EXE}"
          PARENT_SCOPE)
    else()
      message(WARNING "clang-tidy was requested but not found.")
    endif()
  endif()

  if(STARTER_PROJECT_ENABLE_CPPCHECK)
    find_program(CPPCHECK_EXE NAMES cppcheck)
    if(CPPCHECK_EXE)
      set(CMAKE_CXX_CPPCHECK
          "${CPPCHECK_EXE};--enable=warning,style,performance,portability;--suppressions-list=${PROJECT_SOURCE_DIR}/config/cppcheck-suppressions.txt"
          PARENT_SCOPE)
    else()
      message(WARNING "cppcheck was requested but not found.")
    endif()
  endif()

  if(STARTER_PROJECT_ENABLE_IWYU)
    find_program(IWYU_EXE NAMES include-what-you-use iwyu)
    if(IWYU_EXE)
      set(CMAKE_CXX_INCLUDE_WHAT_YOU_USE
          "${IWYU_EXE}"
          PARENT_SCOPE)
    else()
      message(WARNING "include-what-you-use was requested but not found.")
    endif()
  endif()
endfunction()
