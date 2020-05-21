self: super:
let
  # https://github.com/Gabriel439/Haskell-Nix-Derivation-Library
  src = super.fetchFromGitHub {
    owner = "Gabriel439";
    repo = "Haskell-Nix-Derivation-Library";
    rev = "4fb51cff1047dbbfebcceeb12d454aa6c96f09b0";
    sha256 = "0mybs30k6axia3rgf0x2zfx6ks7rlbdh5744473qvnf542k6lg81";
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
