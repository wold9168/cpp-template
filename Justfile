cmake_flags := ""
cmake_build_dir := "build"
nix_build_dir := "result"

# list all available recipes
default:
    @just --list

# configure cmake
cmake-configure:
    cmake -B {{ cmake_build_dir }} {{ cmake_flags }}

# build the project
cmake-build: cmake-configure
    cmake --build {{ cmake_build_dir }}

# build and run the default target
cmake-run: cmake-build
    ./{{ cmake_build_dir }}/main/main

# remove build artifacts
cmake-clean:
    trash {{ cmake_build_dir }}

# full rebuild from scratch
cmake-rebuild: cmake-clean cmake-build

# enter nix devShell
nix-devshell:
    nix develop

# configure direnv
nix-devinit:
    direnv allow

# nix clean (remove result symlink)
nix-clean:
    trash {{ nix_build_dir }}

# nix gc: clean old store
nix-gc:
    nix-collect-garbage

# build with nix (output in result/)
nix-build target_architecture="x86_64-linux":
    nix build .#packages.{{ target_architecture }}.default -o {{ nix_build_dir }}

# nix build + run
nix-run: nix-build
    ./{{ nix_build_dir }}/main/main

# debug nix build result
debug debugger="lldb" args="":
    @test -f {{ nix_build_dir }}/main/main || { echo "error: {{ nix_build_dir }}/main/main not found, build first"; exit 1; }
    {{ debugger }} {{ nix_build_dir }}/main/main {{ args }}
