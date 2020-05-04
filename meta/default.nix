{ nixpkgs ? import <nixpkgs> {} }:
let
  hnSrc = nixpkgs.fetchFromGitHub {
    owner = "sorki";
    repo = "hnix-overlay";
    rev = "a958fb56140e75cf0fed5b8100508236b511e890";
    sha256 = "0iqj1l94lh2bhl5y6bs30zh5207m53784lly2zw763gs304rdb52";
  };
  hn = import hnSrc {};
  src = hn.pkgs.nix-gitignore.gitignoreSource [] ./.;
in
  hn // rec {
    my-lib =
      hn.scope.callCabal2nix "my-lib" "${src}" {};

    shell = hn.mkShell my-lib;
  }
