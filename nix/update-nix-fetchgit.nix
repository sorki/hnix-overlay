self: super:
let
  src = super.fetchFromGitHub {
    owner = "expipiplus1";
    repo = "update-nix-fetchgit";
    rev = "eec9ef8861f0ca5bd5e7826b856dafe0270e0c0d";
    sha256 = "1vx0ppkg8kvsjdq2xwxmhibxp8507hwr2jij7qq2a9kvjh8l7577";
  };

  # swap with src to build from this path
  srcX = ../../update-nix-fetchgit;
in
{
  haskellPackages = super.haskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        update-nix-fetchgit = hself.callCabal2nix "update-nix-fetchgit" "${src}" {};
      });
  });
}
