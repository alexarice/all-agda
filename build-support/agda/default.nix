# Builder for Agda packages.
{
  stdenv,
  lib,
  self,
  Agda,
  wrapper,
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
    agdaWithArgs = withPackages (builtins.filter (p: p ? isAgdaDerivation) buildInputs);
  in {
    inherit libraryName libraryFile;

    isAgdaDerivation = true;

    buildInputs = buildInputs ++ [agdaWithArgs];

    buildPhase =
      if buildPhase != null
      then buildPhase
      else ''
        runHook preBuild
        agda -i ${dirOf everythingFile} ${everythingFile}
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
