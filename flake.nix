{
  description = "All agda versions";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    agda-2_6_1.url = "github:alexarice/agda/2.6.1-flake";
    agda-2_6_2.url = "github:agda/agda/v2.6.2.2";
    agda-2_6_3.url = "github:agda/agda/v2.6.3";
    agda-nightly.url = "github:agda/agda/0e85116e87e53e38cbdfa499f573970d6f78555a";
  };

  outputs = { self, nixpkgs, flake-utils, agda-2_6_1, agda-2_6_2, agda-2_6_3, agda-nightly, ... }:
  flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      legacyPackages = {
        # Development Agda
        agdaPackages-nightly = pkgs.callPackage ./src/base {
          inherit (agda-nightly.packages.${system}) Agda;
          aversion = "nightly";
        };

        agdaPackages-2_6_3 = pkgs.callPackage ./src/base {
          inherit (agda-2_6_3.packages.${system}) Agda;
          aversion = "2.6.3";
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
        inherit (self.legacyPackages."${system}") agdaPackages-nightly agdaPackages-2_6_1 agdaPackages-2_6_2 agdaPackages-2_6_3;
        inherit (self.packages."${system}") agda-nightly agda-2_6_1 agda-2_6_2 agda-2_6_3;
      };

      packages = {
        agda-nightly = self.legacyPackages."${system}".agdaPackages-nightly.agda;
        agda-2_6_1 = self.legacyPackages."${system}".agdaPackages-2_6_1.agda;
        agda-2_6_2 = self.legacyPackages."${system}".agdaPackages-2_6_2.agda;
        agda-2_6_3 = self.legacyPackages."${system}".agdaPackages-2_6_3.agda;
      };
    });
}
