self: super:
let
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "update-nix-file";
    rev = "5a2db8d185e58ca9faa84a0d6aa8e9048f1d8cd6";
    sha256 = "17hc6kzg4493qb9jin6y06ixzia37mhb9i2l9zi378k5ck16lh4k";
  };

  # swap with src to build from this path
  srcX = ../../update-nix-file;
in
{
  haskellPackages = super.haskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        update-nix-file = hself.callCabal2nix "update-nix-file" "${src}" {};
      });
  });
}
