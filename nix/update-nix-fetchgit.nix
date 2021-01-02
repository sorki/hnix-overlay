self: super:
let
  src = super.fetchFromGitHub {
    owner = "expipiplus1";
    repo = "update-nix-fetchgit";
    rev = "7e9fdb1bdd70cf09263c9e36db61c9870830c04a";
    sha256 = "0zwsvm9g25ldq9bp0q5ydfql519j5m218rj3wzbxdwli771yrwfc";
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
