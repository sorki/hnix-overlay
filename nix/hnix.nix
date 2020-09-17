self: super:
let
  # https://github.com/haskell-nix/hnix
  src = super.fetchFromGitHub {
    owner = "haskell-nix";
    repo = "hnix";
    rev = "dfa0435e9e91de3152f3c43ce8f35fa98fc03cbd";
    sha256 = "1j74l3am3d0ql3wrv53q5gng04bbzwp7vm1wj9yikczkcvgm7iny";
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
