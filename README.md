# hnix-overlay

Nix files and Haskell overlay containing Hnix packages and surrounding ecosystem.

Warning: this is currently my `hnix` playground and will change very frequently.

## Usage

To enter development shell for `hnix` install [Nix](https://nixos.org/nix/) and run

```
nix-shell
```

## Targets

### [hnix](https://github.com/haskell-nix/hnix)
### [hnix-store](https://github.com/haskell-nix/hnix-store)
### [update-nix-fetchgit](https://github.com/expipiplus1/update-nix-fetchgit)
### [update-nix-file](https://github.com/sorki/update-nix-file)
### [nix-derivation](https://github.com/Gabriel439/Haskell-Nix-Derivation-Library)
### [nix-diff](https://github.com/Gabriel439/nix-diff)
### [nix-narinfo](https://github.com/sorki/nix-narinfo)
### [hnix-store-experiments](https://github.com/sorki/hnix-store-experiments)

### Build target

To build a specific target use
```
nix-build -A hnix
```

## Shells for targets

To jump to shell for specific project use

```
nix-shell -E "with (import ./default.nix {}); mkShell scope.hnix-store-experiments"
```

You can then jump to projects repo checkout and use `cabal build/repl/run/test`.
