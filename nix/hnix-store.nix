self: super:
let
  # https://github.com/haskell-nix/hnix-store
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "hnix-store";
    rev = "aad97d2273f5bbc1063763568bbb02b29a981b73";
    sha256 = "0hbgwzqcdwrmc9d64pdplxjhb10zb253zk6cz9ah8nvh3jg57gd9";
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
