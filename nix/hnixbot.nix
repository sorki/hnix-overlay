self: super:
let
  # https://github.com/sorki/hnixbot
  src = super.fetchFromGitHub {
    owner = "sorki";
    repo = "hnixbot";
    rev = "46477d50a0e34eb0ce55ad5d89308038a83a4dfb";
    sha256 = "1sxzw9mlymiq0kvk78nrkm7xq9yynbfkc4ya95742v9972adj71l";
  };

  # swap with src to build from this path
  srcX = ../../hnixbot;
in
{
  haskellPackages = super.haskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        hnixbot = hself.callCabal2nix "hnixbot" "${src}" {};
      });
  });
}
