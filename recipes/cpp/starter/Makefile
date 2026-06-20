.PHONY: debug release asan coverage static-analysis format format-check ci configure build test clean distclean

debug:
	cmake --workflow --preset debug

release:
	cmake --workflow --preset release

asan:
	cmake --workflow --preset asan

coverage:
	cmake --workflow --preset coverage

static-analysis:
	cmake --workflow --preset static-analysis

format-check:
	cmake --workflow --preset format-check

format:
	cmake --workflow --preset format

ci:
	cmake --workflow --preset ci-local

configure:
	cmake --preset clang-debug

build:
	cmake --build --preset build-clang-debug

test:
	ctest --preset test-clang-debug

clean:
	cmake --build --preset build-clang-debug --target clean

distclean:
	cmake -E rm -rf build
