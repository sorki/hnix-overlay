self: super:
let
  # https://github.com/haskell-nix/hnix-store
  src = super.fetchFromGitHub {
    owner = "haskell-nix";
    repo = "hnix-store";
    rev = "59e08d49ef125a5f4263d9e2574b9224a6a32fa1";
    sha256 = "1pzv64il08bk6ahqcys6723hzq3lf5kl6xxwapwbjiwrwz61nmzd";
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
