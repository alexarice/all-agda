v:
{ lib, buildGitHub, haskellPackages }:

buildGitHub v {
  pname = "standard-library";
  repo = "agda-stdlib";
  owner = "agda";

  nativeBuildInputs = [ (haskellPackages.ghcWithPackages (self: [ self.filemanip ])) ];
  preConfigure = ''
    runhaskell GenerateEverything.hs
  '';

  meta = with lib; {
    homepage = "https://wiki.portal.chalmers.se/agda/pmwiki.php?n=Libraries.StandardLibrary";
    description = "A standard library for use with the Agda compiler";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
    maintainers = with maintainers; [ alexarice ];
  };
}
