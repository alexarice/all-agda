{ pkgs, lib, newScope, Agda, aversion, agda2hs ? null }:
let
  apkgs = import ../agdaPackages.nix;
  mkAgdaPackages = self:
    let
      callPackage = self.callPackage;
      buildLibrarySet = callPackage ../../build-support/buildLibrarySet {
        inherit apkgs callPackage aversion;
      };
      wrapper = callPackage ../../build-support/wrapper.nix {
        inherit (pkgs.haskellPackages) ghcWithPackages;
        inherit self;
      };

      agda2hsWithPackages = (wrapper {
        tool = agda2hs;
        name = "agda2hs";
      }).withPackages;

      inherit (callPackage ../../build-support/agda {
        inherit Agda;
        inherit self;
        inherit wrapper;
      }) withPackages mkDerivation;
    in
    {
      inherit mkDerivation;
      buildGitHub = callPackage ../../build-support/buildGitHub.nix { };

      all = withPackages (builtins.concatMap (x: lib.filter (x: lib.isDerivation x && x ? isAgdaDerivation) (lib.attrValues x)) (builtins.filter (x: x ? isLibrarySet) (lib.attrValues (removeAttrs self [ "all" ]))));

      agda = withPackages [ ] // { inherit withPackages;inherit (self) agda-mode; };

      agda-mode = epkgs: callPackage ../agda-mode {
        Agda = self.agda;
        inherit epkgs;
      };

      agda2hs = if agda2hs == null then null else agda2hsWithPackages [ ] // { withPackages = agda2hsWithPackages; };

    } // (lib.mapAttrs (n: v: buildLibrarySet n v self) (lib.filterAttrs (n: v: lib.any (x: builtins.elem aversion x.agda) (builtins.attrValues v)) apkgs));
in
lib.makeScope newScope mkAgdaPackages
