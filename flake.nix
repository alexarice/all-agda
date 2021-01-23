{
  description = "All agda versions";

  inputs = {
    haskellNix = {
      url = "github:input-output-hk/haskell.nix";
    };
    nixpkgs.url = "github:nixos/nixpkgs/f217c0ea7c148ddc0103347051555c7c252dcafb";
  };

  outputs = { self, nixpkgs, haskellNix }:
  let
    # haskellNix = import (builtins.fetchTarball {
    #   url = "https://github.com/input-output-hk/haskell.nix/archive/master.tar.gz";
    #   sha256 = "0dzz0zrg62vl22rx9j2z6l15ynff4r2njz0m81b36dblhgk9l2ig";
    # }) {};
    # nixpkgsSrc = haskellNix.sources.nixpkgs-2009;
    # nixpkgsArgs = haskellNix.nixpkgsArgs;
    # pkgs = import nixpkgsSrc nixpkgsArgs;
    pkgs = haskellNix.legacyPackages."x86_64-linux";
    buildAgda = rev: sha256: pkgs.callPackage ./build-agda { inherit rev sha256; };
  in {
    agda-master = buildAgda "e12f391d2539b62a62d18aef74149a9a4695a871" "1lk2ayj87kclwcj83hkw7hg6mdli9fy8wk57hjrbm2b74rk2jw7f";
    agda-2_6_1_2 = buildAgda "v2.6.1.2" "02fl52vx2izbzkky78r26gj28sjgrk2yh79z7l4kxn467myvly3r";
  };
}
