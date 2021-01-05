self: super:
let
  # https://github.com/haskell-nix/hnix
  src = super.fetchFromGitHub {
    owner = "haskell-nix";
    repo = "hnix";
    rev = "8a6ff0766cb55b4b458e2a35cd4c9c06704b0f1f";
    sha256 = "1w2mmblnd00f63cz7wm9l7s5pa3lwg4y420p3x75yxczpqlwr5dz";
    fetchSubmodules = true;
  };

  # swap with src to build from this path
  srcX = ../../hnix;
in
{
  haskellPackages = super.haskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        hnix = hself.callCabal2nix "hnix" "${src}" {};
      });
  });
}
