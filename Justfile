cmake_flags := ""
build_dir := "build"

# list all available recipes
default:
    @just --list

# configure cmake
configure:
    cmake -B {{ build_dir }} {{ cmake_flags }}

# build the project
build: configure
    cmake --build {{ build_dir }}

# build and run the default target
run: build
    ./{{ build_dir }}/main/main

# remove build artifacts
clean:
    trash {{ build_dir }}

# full rebuild from scratch
rebuild: clean build

# enter nix devShell
devshell:
    nix develop

# check flake.nix
fc:
    nix flake check

# configure direnv
devinit:
    direnv allow

# nix gc: clean old store
nix-gc:
    nix-collect-garbage

# debug nix build result
debug debugger="lldb" args="":
    @test -f {{ build_dir }}/main/main || { echo "error: {{ build_dir }}/main/main not found, build first"; exit 1; }
    {{ debugger }} {{ build_dir }}/main/main {{ args }}
