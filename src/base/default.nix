{ pkgs, lib, newScope, Agda, packages }:
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

      agda = withPackages [ ] // { inherit withPackages; inherit (self) agda-mode; };

      agda-mode = epkgs: callPackage ../agda-mode {
        Agda = self.agda;
        inherit epkgs;
      };
    } // packages {
      inherit self buildLibrarySet;
    };
in
lib.makeScope newScope mkAgdaPackages
