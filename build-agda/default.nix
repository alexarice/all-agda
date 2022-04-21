{ haskell-nix
, fetchFromGitHub
, lib
, rev
, sha256
, compiler-nix-name ? "ghc8107"
, sha256map ? null
}:
let
  a = haskell-nix.cabalProject {
    src = fetchFromGitHub {
      owner = "agda";
      repo = "agda";
      inherit rev sha256;
    };
    inherit compiler-nix-name sha256map;
    index-state = "2021-05-24T00:00:00Z";
    modules = [{
      # Credit to @michaelpj on irc for this fix
      packages.Agda.package.buildType = lib.mkForce "Simple";
      packages.Agda.components.library.postInstall = ''
        # Compile the executable using the package DB we've just made, which contains
        # the main Agda library
        ghc src/main/Main.hs -package-db=$out/package.conf.d -o agda
        # Find all the files in $out (would be $data if we had a separate data output)
        shopt -s globstar
        files=($out/**/*.agda)
        for f in "''${files[@]}" ; do
        echo "Compiling $f"
        # This is what the custom setup calls in the end
        ./agda --no-libraries --local-interfaces $f
        done
      '';
    }];
  };
in
{
  inherit (a.Agda.components.exes) agda agda-mode;
}
