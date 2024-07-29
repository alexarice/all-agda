{
  agda2hs-src,
  version,
  mkDerivation,
  Agda,
  base,
  bytestring,
  containers,
  deepseq,
  directory,
  filepath,
  haskell-src-exts,
  lib,
  mtl,
  process,
  syb,
  text,
  unordered-containers,
  yaml-light,
}:
mkDerivation {
  pname = "agda2hs";
  inherit version;
  src = agda2hs-src;
  isLibrary = false;
  isExecutable = true;
  enableSeparateDataOutput = true;
  executableHaskellDepends = [
    Agda
    base
    bytestring
    containers
    deepseq
    directory
    filepath
    haskell-src-exts
    mtl
    process
    syb
    text
    unordered-containers
    yaml-light
  ];
  description = "Compiling Agda code to readable Haskell";
  license = lib.licenses.bsd3;
}
