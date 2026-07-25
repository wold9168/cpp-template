# Nix flake for wold9168/cpp-template
# Before building with this Nix Flake file,
# please review and modify all sections marked as "Changeme".
{
  description = "Nix flake for wold9168/cpp-template"; # Changeme

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # ═══════════════════════════════════════════════════════════
    # Third-party C/C++ libs without Nix support — fetch via flake = false
    # Uncomment and wire into preConfigure below
    # ═══════════════════════════════════════════════════════════

    # ── Example: CMake-based library (not in nixpkgs) ──
    # example-cmake-lib = {
    #   url = "github:user/cmake-library";
    #   flake = false;
    # };

    # ── Example: Makefile/Automake-based library (not in nixpkgs) ──
    # example-makefile-lib = {
    #   url = "github:user/makefile-library";
    #   flake = false;
    # };
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      pkgsFor = system: import nixpkgs { inherit system; };

      genToolchainInputs =
        pkgs: with pkgs; [
          cmake
          gcc
          gdb
          lldb
          just
          direnv
          clang-tools
        ];
      genLibInputs =
        pkgs: with pkgs; [
          # lib from Nixpkgs
          # pkgs.fmt
        ];

      # ═══════════════════════════════════════════════════════════
      # Third-party libs (uncomment inputs above, then uncomment here)
      # ═══════════════════════════════════════════════════════════
      mkThirdPartyLibs = pkgs: with pkgs; [
        # (pkgs.stdenv.mkDerivation {
        #   pname = "example-cmake-lib";
        #   version = "unstable";
        #   src = inputs.example-cmake-lib;
        #   nativeBuildInputs = [ cmake ];
        #   installPhase = ''
        #     mkdir -p $out/lib
        #     cp -r lib/* $out/lib/ 2>/dev/null || true
        #     cp -r include $out/ 2>/dev/null || true
        #   '';
        # })
        # (pkgs.stdenv.mkDerivation {
        #   pname = "example-makefile-lib";
        #   version = "unstable";
        #   src = inputs.example-makefile-lib;
        #   installPhase = ''
        #     mkdir -p $out/lib
        #     cp lib/* $out/lib/ 2>/dev/null || true
        #     cp -r include $out/ 2>/dev/null || true
        #   '';
        # })
      ];

      cppProject =
        {
          system,
          pkgs ? pkgsFor system,
        }:
        pkgs.stdenv.mkDerivation {
          pname = "cpp-template-project"; # Changeme
          version = "0.1.0"; # Changeme

          src = pkgs.lib.cleanSource ./.;

          nativeBuildInputs = with pkgs; [ cmake ];
          buildInputs = genLibInputs pkgs ++ mkThirdPartyLibs pkgs;

          # preConfigure for inputs.example-cmake-lib, inputs.example-makefile-lib
          # ── Build non-Nix third-party libs from inputs ──────
          # Uncomment inputs above, then wire them here:

          # preConfigure = ''
          #   # CMake library
          #   cmake -S ${inputs.example-cmake-lib} \
          #         -B build-example-cmake-lib \
          #         -DCMAKE_INSTALL_PREFIX=$PWD/.deps
          #   cmake --build build-example-cmake-lib
          #   cmake --install build-example-cmake-lib
          #
          #   # Makefile library
          #   make -C ${inputs.example-makefile-lib} \
          #        install PREFIX=$PWD/.deps
          # '';
          #
          # cmakeFlags = [ "-DCMAKE_PREFIX_PATH=$PWD/.deps" ];

          installPhase = ''
            mkdir -p $out
            cp -r . $out
          '';
        };
    in
    {
      packages = forAllSystems (system: {
        default = cppProject { inherit system; };
      });

      devShells = forAllSystems (
        system:
        let
          pkgs = pkgsFor system;
        in
        {
          default = pkgs.mkShell {
            nativeBuildInputs = genToolchainInputs pkgs ++ genLibInputs pkgs ++ mkThirdPartyLibs pkgs;

            shellHook = ''
              echo "nix devShell for cpp-template"
              echo "  cmake : $(cmake --version | head -1)"
              echo "  gcc   : $(gcc --version | head -1)"
              echo "  gdb   : $(gdb --version | head -1)"
              echo "  lldb  : $(lldb --version | head -1)"
              echo "  just  : $(just --version | head -1)"
              echo "  clangd: $(clangd --version | head -1)"
            '';
          };
        }
      );
    };
}
