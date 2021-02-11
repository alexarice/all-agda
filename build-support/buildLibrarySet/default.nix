{ callPackage, lib, apkgs }: name: primaryVersion: attrSet:

let
  set = lib.mapAttrs (n: v: callPackage apkgs."${name}"."${n}" v) attrSet;
in set."${primaryVersion}" // set // { isLibrarySet = true; }
