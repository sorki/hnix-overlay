{ nixpkgs ? import <nixpkgs> {} }:
let
  hnSrc = nixpkgs.fetchFromGitHub {
    owner = "sorki";
    repo = "hnix-overlay";
    rev = "860fb41b4d489e536634fde23adb808c8cf337f1";
    sha256 = "0000000000000000000000000000000000000000000000000000";
  };
  hn = import hnSrc {};
  src = hn.pkgs.nix-gitignore.gitignoreSource [] ./.;
in
  hn // rec {
    my-lib =
      hn.scope.callCabal2nix "my-lib" "${src}" {};

    shell = hn.mkShell my-lib;
  }
