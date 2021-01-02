{ nixpkgs ? import ./nixpkgs.nix {} }:
let
  overlays = import ./overlay.nix;
  # pinned
  pkgs = import ./nixpkgs.nix { inherit overlays; };
  # or switch to system nixpkgs
  # pkgs = import <nixpkgs> { inherit overlays; };
  scope = pkgs.haskellPackages;

  mkShell = x: import ./makeshell.nix {
    inherit pkgs;
    hnix-pkgs = scope;
    shellForPkg = x;
  };
in
rec {
  hnix-pkgs = scope;
  inherit scope;
  inherit (scope)
    hnix
    hnixbot

    hnix-store-core
    hnix-store-remote
    hnix-store-experiments

    nix-linter
    update-nix-fetchgit
    update-nix-file

    nix-derivation
    nix-diff
    nix-narinfo

    ; # yeah

  inherit pkgs;
  inherit mkShell;
}
