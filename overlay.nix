[
  (self: super: {
    haskellPackages = super.haskell.packages.ghc8101;
  })

  (import ./nix/hnix.nix)
  (import ./nix/hnixbot.nix)
  (import ./nix/hnix-store.nix)
  (import ./nix/hnix-store-experiments.nix)

  (import ./nix/nix-linter.nix)
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

      prettyprinter = hsuper.callHackageDirect {
        pkg = "prettyprinter";
        ver = "1.7.0";
        sha256 = "17byy08brwcsl5rqdhibq3pcpgx085shizb2ap6s4xy3izdia3cc"; } {};

      data-fix = hsuper.callHackage "data-fix" "0.3.0" {};

      neat-interpolation = hsuper.callHackage "neat-interpolation" "0.5.1.1" {};

      cryptohash-sha512 = super.haskell.lib.doJailbreak hsuper.cryptohash-sha512;
      which = super.haskell.lib.doJailbreak hsuper.which;

    });

  }); })
]
