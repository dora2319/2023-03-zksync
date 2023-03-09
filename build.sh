#!/usr/bin/env bash

cd era-compiler-tester

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        pacman -S cmake ninja clang lld parallel
elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install cmake ninja coreutils parallel
elif [[ -f '/etc/arch-release' ]]; then
        pacman -S cmake ninja clang lld parallel
else
        echo "Unsupported OS"
        exit 1
fi

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# You may need to restart the shell after the above to have your rust properly registered
cargo install compiler-llvm-builder
zkevm-llvm clone && zkevm-llvm build
cargo build --release
