include_guard(GLOBAL)

function(enable_project_sanitizers target)
  if(MSVC)
    message(WARNING "Sanitizer preset is configured for Clang/GCC-style toolchains.")
    return()
  endif()

  target_compile_options(${target} INTERFACE -fsanitize=address,undefined -fno-omit-frame-pointer)
  target_link_options(${target} INTERFACE -fsanitize=address,undefined)
endfunction()
