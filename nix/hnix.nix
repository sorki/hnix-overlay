self: super:
let
  # https://github.com/haskell-nix/hnix
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "hnix";
    rev = "a89fede9170a3d555a6f0d1adfa3c3c262f8be5b";
    sha256 = "153s3bjspwjy8kvrgagfqgal9yrzgdpmf1xn4cjv9j3cqdmcklmp";
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
