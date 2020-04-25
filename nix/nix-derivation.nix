self: super:
let
  # https://github.com/Gabriel439/Haskell-Nix-Derivation-Library
  src = super.fetchFromGitHub {
    owner = "Gabriel439";
    repo = "Haskell-Nix-Derivation-Library";
    rev = "69cfd0e37f2628645785f74e63732fa3abeced57";
    sha256 = "07rvmpv8ijqdaay9qxim2ii3j367x5qim4fzjnnn1wm9g4c0wlyf";
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
