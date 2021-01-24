{ pkgs, lib, callPackage, newScope, Agda }:

let
  apkgs = import ../agdaPackages.nix;
  mkAgdaPackages = self: let
    callPackage = self.callPackage;
    inherit (callPackage ../../build-support/agda {
      inherit Agda self;
      inherit (pkgs.haskellPackages) ghcWithPackages;
    }) withPackages mkDerivation;
  in {
    inherit mkDerivation;
    buildGitHub = import ../../build-support/buildGitHub.nix;

    agda = withPackages [] // { inherit withPackages; };

    standard-library = callPackage apkgs.standard-library."v1.4" {
      inherit (pkgs.haskellPackages) ghcWithPackages;
    };

    # agda-prelude = callPackage ../development/libraries/agda/agda-prelude { };

    # agda-categories = callPackage ../development/libraries/agda/agda-categories { };

    cubical = callPackage apkgs.cubical."v0.2" { };

    # functional-linear-algebra = callPackage
    #   ../development/libraries/agda/functional-linear-algebra { };

    # generic = callPackage ../development/libraries/agda/generic { };
  };
in lib.makeScope newScope mkAgdaPackages
