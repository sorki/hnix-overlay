self: super:
let
  # https://github.com/sorki/nix-narinfo
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "nix-narinfo";
    rev = "5f1b9cf2f697217a7e81347a00bb26d4b4bb9638";
    sha256 = "0yq3wzb4dfvvbhwfv8yixkqli2bzij9z45xgr68h2mba08019vsm";
  };

  # swap with src to build from this path
  srcX = ../../nix-narinfo;
in
{
  haskellPackages = super.haskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        nix-narinfo = hself.callCabal2nix "nix-narinfo" "${src}" {};
      });
  });
}
