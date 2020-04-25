self: super:
let
  srcX = super.fetchFromGitHub {
    owner = "sorki";
    repo = "update-nix-fetchgit";
    rev = "8f4542a6d0ccab4ad25a3274ceba9c1963d0ccdd";
    sha256 = "1vrdh7wmyvwk92b1kyanmplw07blnzpgjgc82584ng8049yk9rcw";
  };

  # swap with src to build from this path
  src = ../../update-nix-fetchgit;
in
{
  haskellPackages = super.haskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        update-nix-fetchgit = hself.callCabal2nix "update-nix-fetchgit" "${src}" {};
      });
  });
}
