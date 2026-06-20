include_guard(GLOBAL)

function(configure_project_warnings target warnings_as_errors_option)
  if(MSVC)
    target_compile_options(${target} INTERFACE /W4 /permissive-)
    if(${warnings_as_errors_option})
      target_compile_options(${target} INTERFACE /WX)
    endif()
  else()
    target_compile_options(
      ${target}
      INTERFACE
        -Wall
        -Wextra
        -Wpedantic
        -Wconversion
        -Wsign-conversion
        -Wshadow
        -Wnon-virtual-dtor
        -Wold-style-cast)
    if(${warnings_as_errors_option})
      target_compile_options(${target} INTERFACE -Werror)
    endif()
  endif()
endfunction()
