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

# nix gc: clean old store
nix-gc:
    nix-collect-garbage

# debug nix build result
debug debugger="lldb" args="":
    @test -f {{ build_dir }}/main/main || { echo "error: {{ build_dir }}/main/main not found, build first"; exit 1; }
    {{ debugger }} {{ build_dir }}/main/main {{ args }}
