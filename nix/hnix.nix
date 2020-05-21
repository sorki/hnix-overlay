self: super:
let
  # https://github.com/haskell-nix/hnix
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "hnix";
    rev = "d4677f9d9a026517e3a7f0ae9003f1d63db400a0";
    sha256 = "0yvqh512z9xv492im21nxx80cp6h3nhm40rm67khpy4qwh40l9ws";
  };

  # swap with src to build from this path
  srcX = ../../hnix;
in
{
  haskellPackages = super.haskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        hnix = hself.callCabal2nix "hnix" "${src}" {};
      });
  });
}
