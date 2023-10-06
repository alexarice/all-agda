v:
{ lib, buildGitHub }:

buildGitHub v {
  pname = "agda2hs";
  repo = "agda2hs";
  owner = "agda";

  preBuild = ''
    echo "{-# OPTIONS --sized-types #-}" > Everything.agda
    echo "module Everything where" >> Everything.agda
    find lib -name '*.agda' | sed -e 's/lib\///;s/\//./g;s/\.agda$//;s/^/import /' >> Everything.agda
  '';

  meta = with lib; {
    description =
      "Compiling Agda code to readable Haskell";
    homepage = src.meta.homepage;
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ alexarice ];
  };
}
