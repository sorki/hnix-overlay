self: super:
let
  # https://github.com/Gabriel439/Haskell-Nix-Derivation-Library
  src = super.fetchFromGitHub {
    owner = "Gabriel439";
    repo = "Haskell-Nix-Derivation-Library";
    rev = "3f95b84acc5e98865d98817b8b0aa73b7750c5f9";
    sha256 = "06065rvsb2qqg8vqvig895fx5csx6lrcnizl8gpmqrbqznxwfwh6";
  };

  # swap with src to build from this path
  srcX = ../../Haskell-Nix-Derivation-Library;
in
{
  haskellPackages = super.haskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        nix-derivation = hself.callCabal2nix "nix-derivation" "${src}" {};
      });
  });
}
