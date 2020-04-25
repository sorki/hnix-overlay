# UNUSED

self: super:
{
haskellPackages = super.haskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
      (hself: hsuper: {
        mkDerivation = x: (hsuper.mkDerivation x).override(
          {
            # disable library profiling globally
            enableLibraryProfiling = false;
          });
          # on package level we can use
          # super.haskell.lib.disableLibraryProfiling
          # super.haskell.lib.dontHaddock
      });
  });
}
