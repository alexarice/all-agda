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
    hpkgs = haskellNix.legacyPackages."x86_64-linux";
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
    buildAgda = rev: sha256: hpkgs.callPackage ./build-agda { inherit rev sha256; };
  in rec {
    agdaPackages-master = pkgs.callPackage ./src/master {
      Agda = buildAgda "e12f391d2539b62a62d18aef74149a9a4695a871" "1lk2ayj87kclwcj83hkw7hg6mdli9fy8wk57hjrbm2b74rk2jw7f";
    };
    agda-master = agdaPackages-master.agda;
    agdaPackages-2_6_1_2 = pkgs.callPackage ./src/2_6_1_2 {
      Agda = buildAgda "v2.6.1.2" "02fl52vx2izbzkky78r26gj28sjgrk2yh79z7l4kxn467myvly3r";
    };
    agda-2_6_1_2 = agdaPackages-2_6_1_2.agda;
  };
}
