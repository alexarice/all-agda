v: {
  lib,
  buildGitHub,
  standard-library,
}:
buildGitHub v {
  pname = "generics";
  repo = "generics";
  owner = "flupe";

  buildInputs = [
    standard-library
  ];

  meta = with lib; {
    description = "A library for datatype-generic programming in Agda";
    homepage = src.meta.homepage;
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [alexarice];
  };
}
