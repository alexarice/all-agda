v: {
  lib,
  stdenv,
  buildGitHub,
}:
buildGitHub v {
  pname = "agda-prelude";
  owner = "UlfNorell";
  repo = "agda-prelude";

  preConfigure = ''
    cd test
    make everything
    mv Everything.agda ..
    cd ..
  '';

  meta = with lib; {
    homepage = "https://github.com/UlfNorell/agda-prelude";
    description = "Programming library for Agda";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
    maintainers = with maintainers; [alexarice];
  };
}
