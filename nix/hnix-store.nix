self: super:
let
  # https://github.com/haskell-nix/hnix-store
  src = super.fetchFromGitHub {
    owner = "haskell-nix";
    repo = "hnix-store";
    rev = "fd09d29b8bef4904058f033d693e7d928a4a92dc";
    sha256 = "0fxig1ckzknm5g19jzg7rrcpz7ssn4iiv9bs9hff9gfy3ciq4zrs";
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
