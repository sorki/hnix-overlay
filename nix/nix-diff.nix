self: super:
let
  # https://github.com/Gabriel439/nix-diff
  src = super.fetchFromGitHub {
    owner = "Gabriel439";
    repo = "nix-diff";
    rev = "4eef5c771f9ab5ab0c443544d27ae120d5484f40";
    sha256 = "1da0sg0kgzvjvyxwf3ibipl3j4kxmklfh1g0npkhfcdlvkiz8qjg";
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
