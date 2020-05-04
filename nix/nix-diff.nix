self: super:
let
  # https://github.com/Gabriel439/nix-diff
  src = super.fetchFromGitHub {
    owner = "Gabriel439";
    repo = "nix-diff";
    rev = "5223e276f8051a77c2d173ade526c24e6f17178d";
    sha256 = "17vxfygsfzwyzq3s7zn7p7gpjcnqyxlw2k01f9zisihwih5zy527";
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
