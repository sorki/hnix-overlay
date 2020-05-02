self: super:
let
  # https://github.com/sorki/hnix-store-experiments
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "hnix-store-experiments";
    rev = "d513e11abc42a1be15adc4e36194b347d990f306";
    sha256 = "14i77snzgpy83g6k6z2gmc0cq10vy4mqb3hpsmacf8lg3cm2pvwy";
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
