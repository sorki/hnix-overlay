self: super:
let
  # https://github.com/Gabriel439/Haskell-Nix-Derivation-Library
  src = super.fetchFromGitHub {
    owner = "Gabriel439";
    repo = "Haskell-Nix-Derivation-Library";
    rev = "73e2ee56bf0e388693cca1429c82e1c3984498ac";
    sha256 = "02a33xvdy6f5syckm8djz1qhna41mfnvlbn1jcgbgqxchds5g0f0";
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
