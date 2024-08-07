let
  buildDir = import ../build-support/buildDir.nix;
in {
  standard-library = buildDir ./packages/standard-library;
  iowa-stdlib = buildDir ./packages/iowa-stdlib;
  agda-prelude = buildDir ./packages/agda-prelude;
  agda-categories = buildDir ./packages/agda-categories;
  cubical = buildDir ./packages/cubical;
  functional-linear-algebra = buildDir ./packages/functional-linear-algebra;
  generic = buildDir ./packages/generic;
  generics = buildDir ./packages/generics;
}
