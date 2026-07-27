# C++ Template with CMake

Copyright (c) 2025 wold9168

---

This project includes a `.gitignore` file from [github/gitignore](https://github.com/github/gitignore) and two `CMakeLists.txt` files with commonly used features, making it easier to build modular and extensible projects based on this template.

---

Run `init.sh` to bootstrap your development environment if `just` and `direnv` are not installed. The script will install them via `nix profile`, but requires `nix` to already be installed on your system.

# Add more libs

To add more libraries, please follow the standard procedure below:

1. Add the libraries you need in `flake.nix`.
2. Add the library names (e.g., `imtui`) to `target_link_libraries` in the `CMakeLists.txt` file of the corresponding module.
3. Run `nix flake check` to trigger an update of the Nix environment variables.
4. If necessary, restart your editor (especially the corresponding `clangd` process) so that it picks up the new environment variables.

## License

MIT License
