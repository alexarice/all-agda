{
  description = "All agda versions";

  inputs = {
    haskellNix = {
      url = "github:input-output-hk/haskell.nix";
    };
    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.follows = "haskellNix/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, haskellNix, flake-utils, ... }:
  flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
    let
      overlays = [ haskellNix.overlay ];
      pkgs = import nixpkgs { inherit system overlays; inherit (haskellNix) config; };
      # pkgs = nixpkgs.legacyPackages."x86_64-linux";
      buildAgda = args: pkgs.callPackage ./build-agda args;
    in
    {
      legacyPackages = {
        # Development Agda
        agdaPackages-master = pkgs.callPackage ./src/base {
          Agda = buildAgda {
            rev = "a0b3eea0c19c47ffbe2be525316311f5795d760d";
            sha256 = "06hqdmhlxr8air3hfpw434ycfvyjby34ng6xj0knjyfja0044sb0";
          };
          aversion = "master";
        };

        agdaPackages-2_6_2 = pkgs.callPackage ./src/base {
          Agda = buildAgda {
            rev = "v2.6.2.1";
            sha256 = "0p6jh8hyyf7xg0sni2rchck2fd1wyr5v106dfxxm09krxxawh0nh";
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
        inherit (self.legacyPackages."${system}") agdaPackages-master agdaPackages-2_6_1 agdaPackages-2_6_2;
        inherit (self.packages."${system}") agda-master agda-2_6_1 agda-2_6_2;
      };

      packages = {
        agda-master = self.legacyPackages."${system}".agdaPackages-master.agda;
        agda-2_6_1 = self.legacyPackages."${system}".agdaPackages-2_6_1.agda;
        agda-2_6_2 = self.legacyPackages."${system}".agdaPackages-2_6_2.agda;
      };

      devShell = pkgs.mkShell {
        buildInputs = [ (self.packages."${system}".agda-master.withPackages (p: [ p.cubical ])) ];
      };
    });
}
