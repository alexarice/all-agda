{ buildLibrarySet, self, ... }:

{
  standard-library = let
  in buildLibrarySet "standard-library" "1.5" {
    "1.5" = {};
    "1.4" = {};
    "1.3" = {};
  };

  agda-prelude = buildLibrarySet "agda-prelude" "compat-2.6.1" {
    "compat-2.6.1" = {};
  };

  agda-categories = buildLibrarySet "agda-categories" "0.1.5" {
    "0.1.5" = {};
    "0.1.4" = {
      standard-library = self.standard-library."1.4";
    };
  };

  cubical = buildLibrarySet "cubical" "0.2" {
    "0.2" = {};
  };

  functional-linear-algebra = buildLibrarySet "functional-linear-algebra" "0.2" {
    "0.2" = {};
    "0.1" = {
      standard-library = self.standard-library."1.4";
    };
  };

  generic = buildLibrarySet "generic" "0.1.0.2" {
    "0.1.0.2" = {};
    "0.1.0.1" = {
      standard-library = self.standard-library."1.4";
    };
  };
}
