with import <nixpkgs> { };

mkShell {
  buildInputs = [
    agda-pkg
  ];
}
