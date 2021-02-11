v:
{ lib, buildGitHub, standard-library }:

buildGitHub v {
  pname = "agda-categories";
  owner = "agda";
  repo = "agda-categories";

  buildInputs = [ standard-library ];

  meta = with lib; {
    homepage = "https://github.com/agda/agda-categories";
    description = "A new Categories library";
    license = licenses.bsd3;
    platforms = platforms.unix;
    maintainers = with maintainers; [ alexarice ];
  };
}
