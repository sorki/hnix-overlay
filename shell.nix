{ nixpkgs ? import ./nixpkgs.nix {} }:
let
  hnixpkgs = (import ./default.nix { inherit nixpkgs; });
in
  hnixpkgs.mkShell hnixpkgs.hnix
