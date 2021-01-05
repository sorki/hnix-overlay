# Used by ci.nix, update with
# $ nix-prefetch-url --unpack https://github.com/NixOS/nixpkgs/archive/${REVISION}.tar.gz
#
let
  rev="0224ebfc4cdeac3b4f6c9b813dbce5511221a74a";
  hash="1gkalax9wl4xn75mchzvvixlm1naqm4g58smifxnrl0cj27yiwg7";
in
import (
  fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    sha256 = hash;
  }
)
