self: super:
let
  # XXX: publish this first..
  srcX = super.fetchFromGitHub {
    owner = "sorki";
    repo = "update-nix-file";
    rev = "c2d9316e2ad0a0eba5145fe90d028a941156f0b5";
    sha256 = "0blqdw51i7z0160q9mvq8ks4hn9jz4cdfg997aijvl272p005dy3";
  };

  # swap with src to build from this path
  src = ../../update-nix-file;
in
{
  haskellPackages = super.haskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        update-nix-file = hself.callCabal2nix "update-nix-file" "${src}" {};
      });
  });
}
