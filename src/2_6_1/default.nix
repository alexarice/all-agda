{ pkgs, lib, callPackage, newScope, Agda }:
let
  apkgs = import ../agdaPackages.nix;
  mkAgdaPackages = self:
    let
      callPackage = self.callPackage;
      buildLibrarySet = callPackage ../../build-support/buildLibrarySet {
        inherit apkgs callPackage;
      };
      inherit (callPackage ../../build-support/agda {
        inherit (Agda) agda agda-mode script;
        inherit self;
        inherit (pkgs.haskellPackages) ghcWithPackages;
      }) withPackages mkDerivation;
    in
    {
      inherit mkDerivation;
      buildGitHub = callPackage ../../build-support/buildGitHub.nix { };

      all = withPackages (builtins.concatMap (x: lib.filter (x: lib.isDerivation x && x ? isAgdaDerivation) (lib.attrValues x)) (builtins.filter (x: x ? isLibrarySet) (lib.attrValues (removeAttrs self ["all"]))));

      agda = withPackages [ ] // { inherit withPackages; };

      agda-mode = epkgs: callPackage ../agda-mode {
        Agda = self.agda;
        inherit epkgs;
      };

      standard-library = let
        args = {
          inherit (pkgs.haskellPackages) ghcWithPackages;
        };
      in buildLibrarySet "standard-library" "1.5" {
        "1.5" = args;
        "1.4" = args;
        "1.3" = args;
      };

      agda-prelude = buildLibrarySet "agda-prelude" "compat-2.6.1" {
        "compat-2.6.1" = {};
      };

      agda-categories = buildLibrarySet "agda-categories" "0.1.5" {
        "0.1.5" = {};
        "0.1.4" = {
          standard-library = self.standard-library."1.4";
        };
      };

      cubical = buildLibrarySet "cubical" "0.2" {
        "0.2" = {};
      };

      functional-linear-algebra = buildLibrarySet "functional-linear-algebra" "0.2" {
        "0.2" = {};
        "0.1" = {
          standard-library = self.standard-library."1.4";
        };
      };

      generic = buildLibrarySet "generic" "0.1.0.2" {
        "0.1.0.2" = {};
        "0.1.0.1" = {
          standard-library = self.standard-library."1.4";
        };
      };
    };
in
lib.makeScope newScope mkAgdaPackages
