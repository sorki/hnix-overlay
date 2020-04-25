self: super:
let
  # https://github.com/Gabriel439/Haskell-Nix-Derivation-Library
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "Haskell-Nix-Derivation-Library";
    rev = "9221f9b2a9751e57b0f6f8deb61881a3b4b72cd7";
    sha256 = "1n7j8rsymqdyvrgns9lv4rk6jngpsk5j0nk94wgcv4waqb1gn1dd";
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
