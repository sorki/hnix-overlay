[
  (import ./nix/hnix.nix)
  (import ./nix/hnixbot.nix)
  (import ./nix/hnix-store.nix)
  (import ./nix/hnix-store-experiments.nix)

  (import ./nix/update-nix-fetchgit.nix)
  (import ./nix/update-nix-file.nix)

  (import ./nix/nix-derivation.nix)
  (import ./nix/nix-diff.nix)
  (import ./nix/nix-narinfo.nix)

  # XXX: temporary
  (self: super: {
  haskellPackages = super.haskellPackages.override (old: {
    overrides = super.lib.composeExtensions (old.overrides or (_: _: {}))
    (hself: hsuper: {
      # XXX: need testHaskellDepends pkgs.nix haskellPackages.criterion
      hnix = super.haskell.lib.dontCheck hsuper.hnix;
      # XXX: lame, needs to check if have nix-daemon
      # or have nix-daemon provided
      hnix-store-remote = super.haskell.lib.dontCheck hsuper.hnix-store-remote;
    });
  }); })
]
