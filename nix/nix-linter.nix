self: super:
let
  # https://github.com/Synthetica9/nix-linter/
  src = super.fetchFromGitHub {
    owner = "Synthetica9";
    repo = "nix-linter";
    rev = "2516a8cda41f9bb553a1c3eca38e3dd94ebf53de";
    sha256 = "07mn2c9v67wsm57jlxv9pqac9hahw4618vngmj2sfbgihx8997kb";
  };

  # swap with src to build from this path
  srcX = ../../nix-linter;
in
{
  haskellPackages = super.haskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        nix-linter = hself.callCabal2nix "nix-linter" "${src}" {};
      });
  });
}
