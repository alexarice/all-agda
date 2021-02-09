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
      buildAgda = args: hpkgs.callPackage ./build-agda args;
    in
    {
      legacyPackages."x86_64-linux" = rec {
        # Development Agda
        agdaPackages-master = pkgs.callPackage ./src/master {
          Agda = buildAgda {
            rev = "e12f391d2539b62a62d18aef74149a9a4695a871";
            sha256 = "1lk2ayj87kclwcj83hkw7hg6mdli9fy8wk57hjrbm2b74rk2jw7f";
          };
        };

        # Agda 2.6.1.2
        agdaPackages-2_6_1_2 = pkgs.callPackage ./src/2_6_1_2 {
          Agda = buildAgda {
            rev = "v2.6.1.2";
            sha256 = "02fl52vx2izbzkky78r26gj28sjgrk2yh79z7l4kxn467myvly3r";
          };
        };
      };

      packages."x86_64-linux" = {
        agda-master = self.legacyPackages."x86_64-linux".agdaPackages-master.agda;
        agda-2_6_1_2 = self.legacyPackages."x86_64-linux".agdaPackages-2_6_1_2.agda;
      };

      devShell."x86_64-linux" = pkgs.mkShell {
        buildInputs = [ (self.packages."x86_64-linux".agda-master.withPackages (p: [ p.cubical ]))];
      };
    };
}
