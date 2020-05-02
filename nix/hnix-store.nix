self: super:
let
  # https://github.com/haskell-nix/hnix-store
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "hnix-store";
    rev = "ceebe2211c6ef267c7f3ee522764f0364752b188";
    sha256 = "11z2y32n41vplh2anp830hahay6ll32qh1ccilviq9179a4z4ayv";
  };

  # swap with src to build from this path
  srcX = ../../hnix-store;

  subs = [
    "hnix-store-core"
    "hnix-store-remote"
  ];
in
{
  haskellPackages = super.haskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: super.lib.genAttrs subs (sub: hself.callCabal2nix sub "${src}/${sub}" {}));
    });
}
