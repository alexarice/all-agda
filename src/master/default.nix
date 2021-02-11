{ buildLibrarySet, ... }:

{
  cubical = buildLibrarySet "cubical" "devel" {
    "devel" = {};
  };
}
