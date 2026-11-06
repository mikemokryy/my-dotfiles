function use-llvm --description 'Use Homebrew LLVM in this shell'
    set -gx LDFLAGS -L/opt/homebrew/opt/llvm/lib
    set -gx CPPFLAGS -I/opt/homebrew/opt/llvm/include
    set -gx CMAKE_PREFIX_PATH /opt/homebrew/opt/llvm
end
