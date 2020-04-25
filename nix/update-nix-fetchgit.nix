self: super:
let
  src = super.fetchFromGitHub {
    owner = "expipiplus1";
    repo = "update-nix-fetchgit";
    rev = "3a606ea48ac1a761ee48e4d3c842501af4a7c66a";
    sha256 = "0mminxh8sqqnzkscs1jpwfrk82aimy4081xigam2brbs6kj8zhpb";
  };

  # swap with src to build from this path
  srcX = ../../update-nix-fetchgit;
in
{
  haskellPackages = super.haskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        update-nix-fetchgit = hself.callCabal2nix "update-nix-fetchgit" "${src}" {};
      });
  });
}
