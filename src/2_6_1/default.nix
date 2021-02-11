{ pkgs, lib, callPackage, newScope, Agda }:
let
  apkgs = import ../agdaPackages.nix;
  mkAgdaPackages = self:
    let
      callPackage = self.callPackage;
      inherit (callPackage ../../build-support/agda {
        inherit (Agda) agda agda-mode script;
        inherit self;
        inherit (pkgs.haskellPackages) ghcWithPackages;
      }) withPackages mkDerivation;
    in
    {
      inherit mkDerivation;
      buildGitHub = callPackage ../../build-support/buildGitHub.nix { };

      all = withPackages (builtins.filter (x: x ? isAgdaDerivation) (lib.attrValues (removeAttrs self ["all"])));

      agda = withPackages [ ] // { inherit withPackages; };

      standard-library = self.standard-library-1_5;

      standard-library-1_4 = callPackage apkgs.standard-library."1.4" {
        inherit (pkgs.haskellPackages) ghcWithPackages;
      };

      standard-library-1_3 = callPackage apkgs.standard-library."1.3" {
        inherit (pkgs.haskellPackages) ghcWithPackages;
      };

      standard-library-1_5 = callPackage apkgs.standard-library."1.5" {
        inherit (pkgs.haskellPackages) ghcWithPackages;
      };

      agda-prelude = callPackage apkgs.agda-prelude."compat-2.6.1" { };

      agda-categories = self.agda-categories-0_1_5;

      agda-categories-0_1_5 = callPackage apkgs.agda-categories."0.1.5" { };

      agda-categories-0_1_4 = callPackage apkgs.agda-categories."0.1.4" {
        standard-library = self.standard-library-1_4;
      };

      cubical = callPackage apkgs.cubical."0.2" { };

      functional-linear-algebra = self.functional-linear-algebra-0_2;

      functional-linear-algebra-0_2 = callPackage apkgs.functional-linear-algebra."0.2" { };

      functional-linear-algebra-0_1 = callPackage apkgs.functional-linear-algebra."0.1" {
        standard-library = self.standard-library-1_4;
      };

      generic = self.generic-0_1_0_2;

      generic-0_1_0_2 = callPackage apkgs.generic."0.1.0.2" { };

      generic-0_1_0_1 = callPackage apkgs.generic."0.1.0.1" {
        standard-library = self.standard-library-1_4;
      };
    };
in
lib.makeScope newScope mkAgdaPackages
