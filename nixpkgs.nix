# Used by ci.nix, update with
# $ nix-prefetch-url --unpack https://github.com/NixOS/nixpkgs/archive/${REVISION}.tar.gz
#
let
  rev="77a062fe47940f1d1cdfb136934bb42d20094c51";
  hash="0a19fnk18pl31a66g7k81hgjxqazbbx78n5qmmn0s993m67sx5z4";
in
import (
  fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    sha256 = hash;
  }
)
