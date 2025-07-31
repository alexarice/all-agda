# Builder for Agda packages.
{
  stdenv,
  lib,
  self,
  Agda,
  wrapper,
  aversion,
}:
with lib.strings;
with builtins; let
  inherit
    (wrapper {
      tool = Agda;
      name = "agda";
      extra = "makeWrapper ${Agda}/bin/agda-mode $out/bin/agda-mode";
    })
    withPackages
    ;

  extensions = [
    "agda"
    "agda-lib"
    "agdai"
    "lagda"
    "lagda.md"
    "lagda.org"
    "lagda.rst"
    "lagda.tex"
  ];

  defaults = {
    pname,
    buildInputs ? [],
    everythingFile ? "./Everything.agda",
    libraryName ? pname,
    libraryFile ? "${libraryName}.agda-lib",
    buildPhase ? null,
    installPhase ? null,
    extraExtensions ? [],
    ...
  }: let
    agdaWithPkgs = withPackages (builtins.filter (p: p ? isAgdaDerivation) buildInputs);
  in {
    inherit libraryName libraryFile;

    isAgdaDerivation = true;

    buildInputs = buildInputs ++ [agdaWithPkgs];

    buildPhase =
      if buildPhase != null
      then buildPhase
      else if aversion < "2.8.0" then ''
        runHook preBuild
        agda -i ${dirOf everythingFile} ${everythingFile}
        runHook postBuild
      '' else ''
        runHook preBuild
        agda --build-library
        runHook postBuild
      '';

    installPhase =
      if installPhase != null
      then installPhase
      else ''
        runHook preInstall
        mkdir -p $out
        find \( ${concatMapStringsSep " -or " (p: "-name '*.${p}'") (extensions ++ extraExtensions)} \) -exec cp -p --parents -t "$out" {} +
        runHook postInstall
      '';
  };
in {
  mkDerivation = args: stdenv.mkDerivation (args // defaults args);

  inherit withPackages withPackages';
}
