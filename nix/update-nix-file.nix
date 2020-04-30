self: super:
let
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "update-nix-file";
    rev = "233df3768217fa9ed0961726d1d3c088a28ee62a";
    sha256 = "0kdqxq1rv6y9iz90xckwlajs1lka3hf19icdwdxkakn2x35hm6ai";
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
