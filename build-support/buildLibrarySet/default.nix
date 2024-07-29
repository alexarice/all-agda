{
  callPackage,
  lib,
  apkgs,
  aversion,
  ...
}: name: attrSet: self: let
  filteredVersions = lib.filterAttrs (n: v: builtins.elem aversion v.agda) attrSet;
  set = lib.mapAttrs (n: v: callPackage (import v.dir apkgs."${name}"."${n}") (lib.mapAttrs (ni: vi: self."${ni}"."${vi}") v.dep)) filteredVersions;
  versions = lib.attrNames set;
  primaryVersion =
    if versions == []
    then null
    else lib.last (lib.naturalSort (builtins.filter (x: ! (lib.strings.hasInfix "rc" x)) versions));
in
  if primaryVersion == null
  then null
  else set."${primaryVersion}" // set // {isLibrarySet = true;}
