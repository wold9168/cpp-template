# C++ Template with CMake

Copyright (c) 2025 wold9168

---

This project includes a `.gitignore` file from [github/gitignore](https://github.com/github/gitignore) and two `CMakeLists.txt` files with commonly used features, making it easier to build modular and extensible projects based on this template.

---

# intro

Run `init.sh` to bootstrap your development environment if `just` and `direnv` are not installed. The script will install them via `nix profile`, but requires `nix` to already be installed on your system.

# Prerequisites

- `nix`
- `trash-cli`

# Add more libs

To add more libraries, please follow the standard procedure below:

1. Add the libraries you need in `flake.nix`.
2. Add the library names (e.g., `imtui`) to `target_link_libraries` in the `CMakeLists.txt` file of the corresponding module.
3. Run `nix flake check` to trigger an update of the Nix environment variables.
4. If necessary, restart your editor (especially the corresponding `clangd` process) so that it picks up the new environment variables.
    - Users of VSCode/VSCodium can use the extension [mkhl.direnv](https://github.com/direnv/direnv-vscode.git) to restart extension host with latest environment variables. If the environment variables haven't been updated automatically[^1] after saving `flake.nix`, you can run `direnv reload` to toggle it manually.

[^1]: Set `"direnv.restart.automatic": true` for [mkhl.direnv](https://github.com/direnv/direnv-vscode.git).

## License

MIT License
