self: super:
let
  # https://github.com/haskell-nix/hnix-store
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "hnix-store";
    rev = "a217ec237212491b794810e627fbc50c65ad097b";
    sha256 = "0fqx1qgg6d80v9h7v38rh28dq5a60lizasrygn28crs48bp2w0xq";
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
