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
        agdaPackages-master = pkgs.callPackage ./src/base {
          Agda = buildAgda {
            rev = "1bac8797a5987e07ec28284807f57e0cddeb2ba9";
            sha256 = "1d3f1vixxfwvvrafhhnlq9k0flqyfbiwgqinx2xl1arw9xwnp84m";
          };
          aversion = "master";
        };

        agdaPackages-2_6_2 = pkgs.callPackage ./src/base {
          Agda = buildAgda {
            rev = "v2.6.2";
            sha256 = "1ccmryw6vs8d87d5zmjl0kr2kvyd1zxl73344fa7yzqgg2kw1da6";
          };
          aversion = "2.6.2";
        };

        # Agda 2.6.1.3
        agdaPackages-2_6_1 = pkgs.callPackage ./src/base {
          Agda = buildAgda {
            rev = "v2.6.1.3";
            sha256 = "1zl7c0rb5rg867a431apxlzj2flg3hjidamqa5prc1bzpmfaywyz";
          };
          aversion = "2.6.1";
        };
      };

      overlay = _: _: {
        inherit (self.legacyPackages."x86_64-linux") agdaPackages-master agdaPackages-2_6_1 agdaPackages-2_6_2;
        inherit (self.packages."x86_64-linux") agda-master agda-2_6_1 agda-2_6_2;
      };

      packages."x86_64-linux" = {
        agda-master = self.legacyPackages."x86_64-linux".agdaPackages-master.agda;
        agda-2_6_1 = self.legacyPackages."x86_64-linux".agdaPackages-2_6_1.agda;
        agda-2_6_2 = self.legacyPackages."x86_64-linux".agdaPackages-2_6_2.agda;
      };

      devShell."x86_64-linux" = pkgs.mkShell {
        buildInputs = [ (self.packages."x86_64-linux".agda-master.withPackages (p: [ p.cubical ])) ];
      };
    };
}
