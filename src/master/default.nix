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

      agda-mode = epkgs: callPackage ../agda-mode {
        Agda = self.agda;
        inherit epkgs;
      };

      all = withPackages (builtins.filter (x: x ? isAgdaDerivation) (lib.attrValues (removeAttrs self ["all"])));

      agda = withPackages [ ] // { inherit withPackages; inherit (self) agda-mode; };

      cubical = callPackage apkgs.cubical."devel" { };

      standard-library = callPackage apkgs.standard-library."experimental" {
        inherit (pkgs.haskellPackages) ghcWithPackages;
      };
    };
in
lib.makeScope newScope mkAgdaPackages
