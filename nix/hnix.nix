self: super:
let
  # https://github.com/haskell-nix/hnix
  srcX = super.fetchFromGitHub {
    owner = "sorki";
    repo = "hnix";
    rev = "9bcf3f119f5bf5554dcf756dd410858b9356e3ed";
    sha256 = "1k64my9lh09dcrl812ij4w81zbsmh93b8n2z8xd474gncpk9zcf0";
  };

  # swap with src to build from this path
  src = ../../hnix;
in
{
  haskellPackages = super.haskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        hnix = hself.callCabal2nix "hnix" "${src}" {};
      });
  });
}
