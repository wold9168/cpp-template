#!/bin/sh

set -e

NIX_PROFILE="${NIX_PROFILE:-$HOME/.nix-profile}"

# ── check nix ─────────────────────────────────────────────────
if ! command -v nix >/dev/null 2>&1; then
    echo "error: nix not found"
    echo "install nix first: https://nixos.org/download/"
    exit 1
fi

# ── install tools via nix profile ─────────────────────────────
install_if_missing() {
    cmd="$1"
    pkg="$2"
    if command -v "$cmd" >/dev/null 2>&1; then
        echo "ok: $cmd already installed"
        return
    fi
    echo "installing $cmd from $pkg ..."
    nix profile install "$pkg"
    echo "ok: $cmd installed"
}

install_if_missing just nixpkgs#just
install_if_missing direnv nixpkgs#direnv

# ── done ──────────────────────────────────────────────────────
echo ""
echo "done. run 'just' to list available recipes."
echo "to enable direnv, run 'direnv allow' in this directory."