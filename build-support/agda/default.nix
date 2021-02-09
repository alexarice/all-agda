# Builder for Agda packages.

{ stdenv, lib, self, agda, agda-mode, runCommandNoCC, makeWrapper, writeText, mkShell, ghcWithPackages, script }:

with lib.strings;
with builtins;
let
  withPackages' =
    { pkgs
    , ghc ? ghcWithPackages (p: with p; [ ieee ])
    }:
    let
      pkgs' = if builtins.isList pkgs then pkgs else pkgs self;
      library-file = writeText "libraries" ''
        ${(concatMapStringsSep "\n" (p: "${p}/${p.libraryFile}") pkgs')}
      '';
      pname = "agdaWithPackages";
      version = agda.version;
    in
    runCommandNoCC "${pname}-${version}"
      {
        inherit pname version;
        nativeBuildInputs = [ makeWrapper ];
        passthru = {
          unwrapped = agda;
          updateScript = script;
        };
      } ''
      mkdir -p $out/bin
      makeWrapper ${agda-mode}/bin/agda-mode $out/bin/agda-mode
      makeWrapper ${agda}/bin/agda $out/bin/agda \
        --add-flags "--library-file=${library-file}" \
        --add-flags "--with-compiler=${ghc}/bin/ghc" \
        --add-flags "--local-interfaces"
    '';

  withPackages = arg: if builtins.isAttrs arg then withPackages' arg else withPackages' { pkgs = arg; };

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

  defaults =
    { pname
    , buildInputs ? [ ]
    , everythingFile ? "./Everything.agda"
    , libraryName ? pname
    , libraryFile ? "${libraryName}.agda-lib"
    , buildPhase ? null
    , installPhase ? null
    , extraExtensions ? [ ]
    , ...
    }:
    let
      agdaWithArgs = withPackages (builtins.filter (p: p ? isAgdaDerivation) buildInputs);
    in
    {
      inherit libraryName libraryFile;

      isAgdaDerivation = true;

      buildInputs = buildInputs ++ [ agdaWithArgs ];

      buildPhase = if buildPhase != null then buildPhase else ''
        runHook preBuild
        agda -i ${dirOf everythingFile} ${everythingFile}
        runHook postBuild
      '';

      installPhase = if installPhase != null then installPhase else ''
        runHook preInstall
        mkdir -p $out
        find \( ${concatMapStringsSep " -or " (p: "-name '*.${p}'") (extensions ++ extraExtensions)} \) -exec cp -p --parents -t "$out" {} +
        runHook postInstall
      '';
    };
in
{
  mkDerivation = args: stdenv.mkDerivation (args // defaults args);

  inherit withPackages withPackages';
}
