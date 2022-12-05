{
  description = "All agda versions";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    agda-2_6_1.url = "github:alexarice/agda/2.6.1-flake";
    agda-2_6_2.url = "github:agda/agda/v2.6.2.2";
    agda-master.url = "github:agda/agda";
  };

  outputs = { self, nixpkgs, flake-utils, agda-2_6_1, agda-2_6_2, agda-master, ... }:
  flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      legacyPackages = {
        # Development Agda
        agdaPackages-master = pkgs.callPackage ./src/base {
          inherit (agda-master.packages.${system}) Agda;
          aversion = "master";
        };

        agdaPackages-2_6_2 = pkgs.callPackage ./src/base {
          inherit (agda-2_6_2.packages.${system}) Agda;
          aversion = "2.6.2";
        };

        # Agda 2.6.1.3
        agdaPackages-2_6_1 = pkgs.callPackage ./src/base {
          inherit (agda-2_6_1.packages.${system}) Agda;
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
