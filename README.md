# C++ Template with CMake

Copyright (c) 2025 wold9168

---

This project includes a `.gitignore` file from [github/gitignore](https://github.com/github/gitignore) and two `CMakeLists.txt` files with commonly used features, making it easier to build modular and extensible projects based on this template.

---

Run `init.sh` to bootstrap your development environment if `just` and `direnv` are not installed. The script will install them via `nix profile`, but requires `nix` to already be installed on your system.

## Justfile

The build targets in the `Justfile` are divided into two categories: those prefixed with `cmake` are intended for users who do not wish to use Nix, and those prefixed with `nix` are for users who prefer to use Nix.

We do not recommend mixing these two types of commands. However, the build targets that are not prefixed with either `cmake` or `nix` can be used for both groups equally.

## License

MIT License
