self: super:
let
  # https://github.com/Gabriel439/nix-diff
  srcX = super.fetchFromGitHub {
    owner = "sorki";
    repo = "nix-diff";
    rev = "a2f8ad0706347fd88f3095982e8d48a6d5fb65ff";
    sha256 = "13khqlsaddl5xg381davwxn37ckxhq4xp4kk8li9gdjbngh31x1p";
  };

  # swap with src to build from this path
  src = ../../nix-diff;
in
{
  haskellPackages = super.haskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        nix-diff = hself.callCabal2nix "nix-diff" "${src}" {};
      });
  });
}
