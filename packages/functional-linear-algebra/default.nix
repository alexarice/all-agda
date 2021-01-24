v:
{ lib, buildGitHub, standard-library }:

buildGitHub v {
  pname = "functional-linear-algebra";
  repo = "functional-linear-algebra";
  owner = "ryanorendorff";

  buildInputs = [ standard-library ];

  meta = with lib; {
    homepage = "https://github.com/ryanorendorff/functional-linear-algebra";
    description = ''
      Formalizing linear algebra in Agda by representing matrices as functions
      from one vector space to another.
    '';
    license = licenses.bsd3;
    platforms = platforms.unix;
    maintainers = with maintainers; [ alexarice ];
  };
}
