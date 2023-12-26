v:
{ lib, buildGitHub, standard-library }:

buildGitHub v {
  pname = "agda-categories";
  owner = "agda";
  repo = "agda-categories";

  buildInputs = [ standard-library ];

  postPatch = lib.optionalString (v.version > "0.1.7.1") ''
    find src -name '*.agda' | sed -e 's|^src/[/]*|import |' -e 's|/|.|g' -e 's/.agda//' -e '/import Everything/d' | LC_COLLATE='C' sort > Everything.agda
  '';

  buildPhase = ''
    agda +RTS -M8G -RTS -i . Everything.agda
  '';

  meta = with lib; {
    homepage = "https://github.com/agda/agda-categories";
    description = "A new Categories library";
    license = licenses.bsd3;
    platforms = platforms.unix;
    maintainers = with maintainers; [ alexarice ];
  };
}
