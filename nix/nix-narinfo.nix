self: super:
let
  # https://github.com/sorki/nix-narinfo
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "nix-narinfo";
    rev = "d630bea022baa90f2f020d5bda73b1424d8a8a3c";
    sha256 = "0wgi3cw50jkallqq5zhvlfjx6prvfvji070qgdyfgc2kxxhq2gxz";
  };

  # swap with src to build from this path
  srcX = ../../nix-narinfo;
in
{
  haskellPackages = super.haskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        nix-narinfo = hself.callCabal2nix "nix-narinfo" "${src}" {};
      });
  });
}
