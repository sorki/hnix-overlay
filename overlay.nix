[
  (self: super: {
    haskellPackages = super.haskell.packages.ghc8101;
  })

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
      # testHaskellDepends haskellPackages.criterion
      # testSystemDepends pkgs.nix
      hnix = hsuper.hnix.overrideAttrs (attrs: {
        buildInputs = attrs.buildInputs ++ [ super.nix ];
        doCheck = false; # now attempts to access real store socket
      });

      hnix-store-remote = hsuper.hnix-store-remote.overrideAttrs (attrs: {
        buildInputs = attrs.buildInputs ++ [ super.nix super.which ];
      });

      # ghc8101
      # bounds
      cryptohash-sha512 = super.haskell.lib.doJailbreak hsuper.cryptohash-sha512;
      constraints-extras = super.haskell.lib.doJailbreak hsuper.constraints-extras;
      http-media =  super.haskell.lib.doJailbreak hsuper.http-media;

      # https://github.com/DanBurton/lens-family-th/pull/17
      lens-family-th = hsuper.callCabal2nix "lens-family-th" (super.fetchFromGitHub {
        owner = "sorki";
        repo = "lens-family-th";
        rev = "ghc8101";
        sha256 = "0s95fv2ra5qn0z61piqwb2xbfiayga45w05j2r97ig6vrrdz23kc";
      }) {};
      indexed-profunctors =  super.haskell.lib.doJailbreak hsuper.indexed-profunctors;

      # polysemy
      first-class-families = super.haskell.lib.doJailbreak hsuper.first-class-families;
      # failing "who needs Weaving even?" test
      polysemy = super.haskell.lib.dontCheck hsuper.polysemy;
      # https://github.com/polysemy-research/loopbreaker/pull/11
      loopbreaker = hsuper.callCabal2nix "loopbreaker" (super.fetchFromGitHub {
        owner = "Avi-D-coder";
        repo = "loopbreaker";
        rev = "810";
        sha256 = "1vi9qv6ga41rsh54x21fjh9lgj0badd112x19b31273rvq6ivxpc";
      }) {};
    });

  }); })
]
