self: super:
let
  # https://github.com/Gabriel439/nix-diff
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "nix-diff";
    rev = "6be72e3533e763db86ffa13377948f6e86282436";
    sha256 = "0rnx5r9zcbrv0y0n690p9p0p8pa4bmkz36ydmqykp9wq23j6mzv3";
  };

  # swap with src to build from this path
  srcX = ../../nix-diff;
in
{
  haskellPackages = super.haskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        nix-diff = hself.callCabal2nix "nix-diff" "${src}" {};
      });
  });
}
