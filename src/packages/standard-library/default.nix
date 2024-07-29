v: {
  lib,
  buildGitHub,
  haskellPackages,
  glibcLocales,
}:
buildGitHub v {
  pname = "standard-library";
  repo = "agda-stdlib";
  owner = "agda";

  LC_ALL = "en_US.UTF-8";

  nativeBuildInputs = [glibcLocales (haskellPackages.ghcWithPackages (self: [self.filemanip]))];
  preConfigure = ''
    runhaskell GenerateEverything.hs ${
      if v.version >= "2.0"
      then "--include-deprecated"
      else ""
    }
  '';

  meta = with lib; {
    homepage = "https://wiki.portal.chalmers.se/agda/pmwiki.php?n=Libraries.StandardLibrary";
    description = "A standard library for use with the Agda compiler";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
    maintainers = with maintainers; [alexarice];
  };
}
