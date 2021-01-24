{ pkgs, lib, callPackage, newScope, Agda }:
let
  apkgs = import ../agdaPackages.nix;
  mkAgdaPackages = self:
    let
      callPackage = self.callPackage;
      inherit (callPackage ../../build-support/agda {
        inherit (Agda) agda agda-mode li;
        inherit self;
        inherit (pkgs.haskellPackages) ghcWithPackages;
      }) withPackages mkDerivation;
    in
    {
      inherit mkDerivation;
      buildGitHub = callPackage ../../build-support/buildGitHub.nix { };

      agda = withPackages [ ] // { inherit withPackages; };

      standard-library = self.standard-library-1_4;

      standard-library-1_4 = callPackage apkgs.standard-library."v1.4" {
        inherit (pkgs.haskellPackages) ghcWithPackages;
      };

      standard-library-1_3 = callPackage apkgs.standard-library."v1.3" {
        inherit (pkgs.haskellPackages) ghcWithPackages;
      };

      standard-library-1_5_rc1 = callPackage apkgs.standard-library."v1.5-rc1" {
        inherit (pkgs.haskellPackages) ghcWithPackages;
      };

      # agda-prelude = callPackage ../development/libraries/agda/agda-prelude { };

      # agda-categories = callPackage ../development/libraries/agda/agda-categories { };

      cubical = callPackage apkgs.cubical."v0.2" { };

      # functional-linear-algebra = callPackage
      #   ../development/libraries/agda/functional-linear-algebra { };

      # generic = callPackage ../development/libraries/agda/generic { };
    };
in
lib.makeScope newScope mkAgdaPackages
