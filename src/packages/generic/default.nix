v:
{ lib, buildGitHub, standard-library }:

buildGitHub v {
  pname = "generic";
  repo = "Generic";
  owner = "effectfully";

  buildInputs = [
    standard-library
  ];

  preBuild = ''
    echo "module Everything where" > Everything.agda
    find src -name '*.agda' | sed -e 's/src\///;s/\//./g;s/\.agda$//;s/^/import /' >> Everything.agda
  '';

  meta = with lib; {
    description =
      "A library for doing generic programming in Agda";
    homepage = src.meta.homepage;
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ alexarice ];
  };
}
