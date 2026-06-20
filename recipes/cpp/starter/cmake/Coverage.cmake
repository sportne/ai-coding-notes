include_guard(GLOBAL)

function(enable_project_coverage target)
  if(NOT CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    message(WARNING "Coverage preset expects GCC and gcovr.")
    return()
  endif()

  target_compile_options(${target} INTERFACE --coverage -O0 -g)
  target_link_options(${target} INTERFACE --coverage)
endfunction()
