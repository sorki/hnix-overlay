self: super:
let
  # https://github.com/haskell-nix/hnix-store
  src = super.fetchFromGitHub {
    owner = "haskell-nix";
    repo = "hnix-store";
    rev = "46cf3fc58f2cff7a0c6e0424cffcf50d382ce581";
    sha256 = "0r3v7xw8h5qkj79i5z2srfcfwy4s0jd2nlmd2kql1l3h9y929bz4";
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
