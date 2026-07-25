cmake_flags := ""
build_dir := "build"

# list all available recipes
default:
    @just --list

# configure cmake
cmake-configure:
    cmake -B {{ build_dir }} {{ cmake_flags }}

# build the project
cmake-build: cmake-configure
    cmake --build {{ build_dir }}

# build and run the default target
cmake-run: cmake-build
    ./{{ build_dir }}/main/main

# remove build artifacts
cmake-clean:
    trash {{ build_dir }}

# full rebuild from scratch
cmake-rebuild: cmake-clean cmake-build

# enter nix devShell
nix-devshell:
    nix develop

# configure direnv
nix-devinit:
    direnv allow

# nix clean (remove result symlink and nix build dirs)
nix-clean:
    trash result result-*

# build with nix (output in result/)
nix-build:
    nix build

# nix build + run
nix-run: nix-build
    ./result/bin/main
