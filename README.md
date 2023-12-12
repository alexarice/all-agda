# All-Agda

Repository to contain nix expressions for all agda versions 2.6.1 onwards.

Currently just contains libraries that have been added to nixpkgs.

Binaries of all packages have been pushed to cachix and can be accessed by running
```
cachix use all-agda
```

## Updating

To update cachix, run:
```
nix build .#agdaPackages-{version}.all --json | jq .[0].outputs.out -r | cachix push all-agda
```
