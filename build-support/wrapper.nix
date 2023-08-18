{ lib, ghcWithPackages, runCommandNoCC, writeText, makeWrapper }:
{ tool, name, extra ? "" }:

with lib.strings;
with builtins;

rec {
  withPackages' =
    { pkgs
    , ghc ? ghcWithPackages (p: with p; [ ieee ])
    }:
    let
      pkgs' = if builtins.isList pkgs then pkgs else pkgs self;
      library-file = writeText "libraries" ''
        ${(concatMapStringsSep "\n" (p: "${p}/${p.libraryFile}") pkgs')}
      '';
      pname = "${name}WithPackages";
      version = tool.version;
    in
    runCommandNoCC "${pname}-${version}"
      {
        inherit pname version;
        nativeBuildInputs = [ makeWrapper ];
        passthru = {
          unwrapped = tool;
        };
      } ''
      mkdir -p $out/bin

      makeWrapper ${tool}/bin/${name} $out/bin/${name} \
        --add-flags "--library-file=${library-file}" \
        --add-flags "--with-compiler=${ghc}/bin/ghc" \
        --add-flags "--local-interfaces"
    '';

    withPackages = arg: if builtins.isAttrs arg then withPackages' arg else withPackages' { pkgs = arg; };
}
