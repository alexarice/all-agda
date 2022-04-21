{
  description = "All agda versions";

  inputs = {
    haskellNix = {
      url = "github:input-output-hk/haskell.nix";
      inputs.nixpkgs.url = "github:NixOS/nixpkgs/1882c6b7368fd284ad01b0a5b5601ef136321292";
    };
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/1882c6b7368fd284ad01b0a5b5601ef136321292";
    nixpkgs.url = "github:NixOS/nixpkgs/1882c6b7368fd284ad01b0a5b5601ef136321292";

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
            rev = "b612cabaae94e8b261491c3bc718ffb4805236f0";
            sha256 = "1aix726zn7cgrpgjv6m451a5s5nvsvjq94scrh8krbwxnaxcjs1d";
          };
          aversion = "master";
        };

        agdaPackages-2_6_2 = pkgs.callPackage ./src/base {
          Agda = buildAgda {
            rev = "v2.6.2.2";
            sha256 = "0kskd56y71p4w1bgr15szbzjl05kfxpf1cs4bd9dnwdwfp5s0ygw";
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
    });
}
