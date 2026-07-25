# C++ Template with CMake

Copyright (c) 2025 wold9168

---

This project includes a `.gitignore` file from [github/gitignore](https://github.com/github/gitignore) and two `CMakeLists.txt` files with commonly used features, making it easier to build modular and extensible projects based on this template.

---

Run `init.sh` to bootstrap your development environment if `just` and `direnv` are not installed. The script will install them via `nix profile`, but requires `nix` to already be installed on your system.

## Justfile

The build targets in the `Justfile` are divided into two categories: those prefixed with `cmake` are intended for users who do not wish to use Nix, and those prefixed with `nix` are for users who prefer to use Nix.

We do not recommend mixing these two types of commands. However, the build targets that are not prefixed with either `cmake` or `nix` can be used for both groups equally.

### About `compile_commands.json`

Any direct manipulation of `compile_commands.json` inside the build-time sandbox is inelegant and unintuitive, and makes it difficult for developers to customise the Nix facilities of this template to their own needs.

Therefore, we distinguish between `cmake-*` and `nix-*` commands.

- `cmake-build` will create `compile_commands.json` inside the `build/` directory.
- `nix-build` will symlink `target` to the final build artefact and also create `compile_commands.json`.

I have pulled the corresponding libraries into the devShell, which should allow `cmake-build` to use the correct library paths for the `compile_commands.json` created in the `build/` directory. The latter, since it runs in a sandboxed environment, will most likely have its `compile_commands.json` pointing to a non‑existent path.

However, if you use the shell environment provided by `direnv`, libraries from the host system may not be completely isolated from the current build environment. If you need to ensure reproducibility, you should use `nix develop` provided by Nix – that is, `just nix-devshell`.

## License

MIT License
