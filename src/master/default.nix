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

      cubical = callPackage apkgs.cubical."devel" { };
    };
in
lib.makeScope newScope mkAgdaPackages
