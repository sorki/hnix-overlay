self: super:
let
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "update-nix-file";
    rev = "ad403151b50683967e0b4887bdd701d1d9aae5eb";
    sha256 = "06lji825d3xmg24pvd24cn92djfcbmidrsxx2jlsnfrl9h1xdvd0";
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
