{ version, ... }@v:
{ lib, buildGitHub, ghc, glibcLocales }:

buildGitHub v {
  pname = "cubical";
  repo = "cubical";
  owner = "agda";

  LC_ALL = "en_US.UTF-8";

  # The cubical library has several `Everything.agda` files, which are
  # compiled through the make file they provide.
  nativeBuildInputs = [ ghc glibcLocales ];
  buildPhase = ''
    make
  '';

  patches = lib.optional (version == "devel") [ ./no_werror_patch.txt ];

  meta = with lib; {
    description =
      "A cubical type theory library for use with the Agda compiler";
    homepage = src.meta.homepage;
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ alexarice ];
  };
}
