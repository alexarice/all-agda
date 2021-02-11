{ mkDerivation, fetchFromGitHub }:
{ version, rev, sha256, ... }:
{ owner, repo, ... }@args:


mkDerivation ({
  inherit version;

  src = fetchFromGitHub {
    inherit owner repo rev sha256;
  };
} // (builtins.removeAttrs args [ "owner" "repo" ]))
