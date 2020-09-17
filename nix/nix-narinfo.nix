self: super:
let
  # https://github.com/sorki/nix-narinfo
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "nix-narinfo";
    rev = "3374e8bcdfc29f7b4116c4f2f28837e35d9e9c9e";
    sha256 = "05nb5vij5rb9ad7jqdr7y45qmzblj7ii0hc6p98yv4n6zf40ikj9";
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
