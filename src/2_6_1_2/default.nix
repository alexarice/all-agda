{ pkgs, lib, callPackage, newScope, Agda }:
let
  apkgs = import ../agdaPackages.nix;
  mkAgdaPackages = self:
    let
      callPackage = self.callPackage;
      inherit (callPackage ../../build-support/agda {
        inherit (Agda) agda agda-mode;
        inherit self;
        inherit (pkgs.haskellPackages) ghcWithPackages;
      }) withPackages mkDerivation;
    in
    {
      inherit mkDerivation;
      buildGitHub = callPackage ../../build-support/buildGitHub.nix { };

      all = withPackages (builtins.filter (x: x ? isAgdaDerivation) (lib.attrValues (removeAttrs self ["all"])));

      agda = withPackages [ ] // { inherit withPackages; };

      standard-library = self.standard-library-1_4;

      standard-library-1_4 = callPackage apkgs.standard-library."1.4" {
        inherit (pkgs.haskellPackages) ghcWithPackages;
      };

      standard-library-1_3 = callPackage apkgs.standard-library."1.3" {
        inherit (pkgs.haskellPackages) ghcWithPackages;
      };

      standard-library-1_5_rc1 = callPackage apkgs.standard-library."1.5-rc1" {
        inherit (pkgs.haskellPackages) ghcWithPackages;
      };

      agda-prelude = callPackage apkgs.agda-prelude."compat-2.6.1" { };

      agda-categories = callPackage apkgs.agda-categories."0.1.4" { };

      cubical = callPackage apkgs.cubical."0.2" { };

      # functional-linear-algebra = callPackage
      #   ../development/libraries/agda/functional-linear-algebra { };

      # generic = callPackage ../development/libraries/agda/generic { };
    };
in
lib.makeScope newScope mkAgdaPackages
