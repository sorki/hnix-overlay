self: super:
let
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "update-nix-fetchgit";
    rev = "7f098f10a93e3e3b3926af31e6278011d2d1d19e";
    sha256 = "1rk5kl4ncxqmyyx11kibry8kg1k9yfflvh4wqbljg8i0dx7hgs7g";
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
