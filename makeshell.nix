{ pkgs, hnix-pkgs, shellForPkg }:
pkgs.stdenv.mkDerivation {
  name = "hnix-shell-${shellForPkg.name}";

  # dummy
  src = ./default.nix;
  phases = [];

  buildInputs = [
    shellForPkg.env.nativeBuildInputs

    hnix-pkgs.cabal-install
    hnix-pkgs.ghcid
    # XXX: hnix uses brittany as well
  ];

  shellHook = ''
    echo "hnix-overlay shell for ${shellForPkg.name}"
  '';
}
