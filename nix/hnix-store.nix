self: super:
let
  # https://github.com/haskell-nix/hnix-store
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "hnix-store";
    rev = "b5e9bc84ad272fc2725c4fbfe85f4a07943bd3cc";
    sha256 = "19j2971rvbk0ilx1vigrsn3gz8afw60gig6fzhp40jpklcix6qk2";
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
