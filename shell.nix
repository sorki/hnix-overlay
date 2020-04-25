{ nixpkgs ? import ./nixpkgs.nix {} }:
(import ./default.nix { inherit nixpkgs; }).shell
