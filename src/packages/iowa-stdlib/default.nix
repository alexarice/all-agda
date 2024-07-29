v: {
  lib,
  buildGitHub,
}:
buildGitHub v {
  pname = "iowa-stdlib";
  owner = "cedille";
  repo = "ial";

  libraryFile = "";
  libraryName = "IAL-1.3";

  buildPhase = ''
    patchShebangs find-deps.sh
    make
  '';

  meta = {
    homepage = "https://github.com/cedille/ial";
    description = "Agda standard library developed at Iowa";
    license = lib.licenses.free;
    platforms = lib.platforms.unix;
    # broken since Agda 2.6.1
    broken = true;
    maintainers = with lib.maintainers; [alexarice];
  };
}
