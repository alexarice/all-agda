{ callCabal2nix, agda2hs-src, mkDerivation }:

callCabal2nix "agda2hs" agda2hs-src ({
  mkDerivation = args: mkDerivation (args // {
    version = "master";
    doCheck = false;
  });
})
