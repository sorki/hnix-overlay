# Used by ci.nix, update with
# $ nix-prefetch-url --unpack https://github.com/NixOS/nixpkgs/archive/${REVISION}.tar.gz
#
let
  rev="0010ae4960d35243e7abb046cd26ddda904a4c63";
  hash="1y55mfm6cz7dwa8jk9873w4wpqp693mw4xfazq5k52wg48d9sfxd";
in
import (
  fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    sha256 = hash;
  }
)
