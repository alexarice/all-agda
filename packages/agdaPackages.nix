let
  buildDir = import ../build-support/buildDir.nix;
in {
  standard-library = buildDir ./standard-library;
  iowa-stdlib = buildDir ./iowa-stdlib;
  agda-prelude = buildDir ./agda-prelude;
  agda-categories = buildDir ./agda-categories;
  cubical = buildDir ./cubical;
  functional-linear-algebra = buildDir ./functional-linear-algebra;
  generic = buildDir ./generic;
}
