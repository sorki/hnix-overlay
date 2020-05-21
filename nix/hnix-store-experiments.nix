self: super:
let
  # https://github.com/sorki/hnix-store-experiments
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "hnix-store-experiments";
    rev = "de43c4d87011cdf5108bfe48e248cc4d80707ddd";
    sha256 = "14kh1mafja74xjy92i2kfiicb3k1d2qkgsrs6vsby5vw2h9kphzr";
  };

  # swap with src to build from this path
  srcX = ../../hnix-store-experiments;
in
{
  haskellPackages = super.haskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        hnix-store-experiments = hself.callCabal2nix "hnix-store-experiments" "${src}" {};
      });
  });
}
