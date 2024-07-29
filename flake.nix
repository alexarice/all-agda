{
  description = "All agda versions";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    agda-2_6_1.url = "github:alexarice/agda/2.6.1-flake";
    agda-2_6_2.url = "github:agda/agda/v2.6.2.2";
    agda-2_6_3.url = "github:agda/agda/v2.6.3";
    agda-2_6_4.url = "github:agda/agda/v2.6.4.3";
    agda-rc.url = "github:agda/agda/v2.6.20240714";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    agda-2_6_1,
    agda-2_6_2,
    agda-2_6_3,
    agda-2_6_4,
    agda-rc,
    ...
  }:
    flake-utils.lib.eachSystem ["x86_64-linux"] (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      legacyPackages = {
        # Release candidate
        agdaPackages-rc = pkgs.callPackage ./src/base {
          Agda = agda-rc.packages.${system}.default;
          aversion = "2.7.0";
        };

        agdaPackages-2_6_4 = pkgs.callPackage ./src/base {
          inherit (agda-2_6_4.packages.${system}) Agda;
          aversion = "2.6.4";
        };

        agdaPackages-2_6_3 = pkgs.callPackage ./src/base {
          inherit (agda-2_6_3.packages.${system}) Agda;
          aversion = "2.6.3";
        };

        agdaPackages-2_6_2 = pkgs.callPackage ./src/base {
          inherit (agda-2_6_2.packages.${system}) Agda;
          aversion = "2.6.2";
        };

        agdaPackages-2_6_1 = pkgs.callPackage ./src/base {
          inherit (agda-2_6_1.packages.${system}) Agda;
          aversion = "2.6.1";
        };
      };

      overlay = _: _: {
        inherit (self.legacyPackages."${system}") agdaPackages-rc agdaPackages-2_6_1 agdaPackages-2_6_2 agdaPackages-2_6_3 agdaPackages-2_6_4;
        inherit (self.packages."${system}") agda-rc agda-2_6_1 agda-2_6_2 agda-2_6_3 agda-2_6_4;
      };

      packages = {
        agda-rc = self.legacyPackages."${system}".agdaPackages-rc.agda;
        agda-2_6_1 = self.legacyPackages."${system}".agdaPackages-2_6_1.agda;
        agda-2_6_2 = self.legacyPackages."${system}".agdaPackages-2_6_2.agda;
        agda-2_6_3 = self.legacyPackages."${system}".agdaPackages-2_6_3.agda;
        agda-2_6_4 = self.legacyPackages."${system}".agdaPackages-2_6_4.agda;
      };
    });
}
