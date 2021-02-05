{ epkgs, Agda }:

epkgs.trivialBuild {
  pname = "agda-mode";
  version = Agda.version;

  phases = [ "buildPhase" "installPhase" ];

  # already byte-compiled by Agda builder
  buildPhase = ''
    agda=`${Agda}/bin/agda-mode locate`
    cp `dirname $agda`/*.el* .
  '';
}
