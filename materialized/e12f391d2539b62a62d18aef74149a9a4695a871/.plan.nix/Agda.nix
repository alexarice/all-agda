{ system
  , compiler
  , flags
  , pkgs
  , hsPkgs
  , pkgconfPkgs
  , errorHandler
  , config
  , ... }:
  {
    flags = { cpphs = false; debug = false; enable-cluster-counting = false; };
    package = {
      specVersion = "1.10";
      identifier = { name = "Agda"; version = "2.6.2"; };
      license = "LicenseRef-OtherLicense";
      copyright = "(c) 2005-2020 The Agda Team.";
      maintainer = "Ulf Norell <ulfn@chalmers.se>";
      author = "Ulf Norell and The Agda Team, see https://agda.readthedocs.io/en/latest/team.html";
      homepage = "http://wiki.portal.chalmers.se/agda/";
      url = "";
      synopsis = "A dependently typed functional programming language and proof assistant";
      description = "Agda is a dependently typed functional programming language: It has\ninductive families, which are similar to Haskell's GADTs, but they\ncan be indexed by values and not just types. It also has\nparameterised modules, mixfix operators, Unicode characters, and an\ninteractive Emacs interface (the type checker can assist in the\ndevelopment of your code).\n\nAgda is also a proof assistant: It is an interactive system for\nwriting and checking proofs. Agda is based on intuitionistic type\ntheory, a foundational system for constructive mathematics developed\nby the Swedish logician Per Martin-L&#xf6;f. It has many\nsimilarities with other proof assistants based on dependent types,\nsuch as Coq, Epigram and NuPRL.\n\nThis package includes both a command-line program (agda) and an\nEmacs mode. If you want to use the Emacs mode you can set it up by\nrunning @agda-mode setup@ (see the README).\n\nNote that the Agda package does not follow the package versioning\npolicy, because it is not intended to be used by third-party\npackages.";
      buildType = "Custom";
      isLocal = true;
      setup-depends = [
        (hsPkgs.buildPackages.base or (pkgs.buildPackages.base or (errorHandler.buildToolDepError "base")))
        (hsPkgs.buildPackages.Cabal or (pkgs.buildPackages.Cabal or (errorHandler.buildToolDepError "Cabal")))
        (hsPkgs.buildPackages.directory or (pkgs.buildPackages.directory or (errorHandler.buildToolDepError "directory")))
        (hsPkgs.buildPackages.filepath or (pkgs.buildPackages.filepath or (errorHandler.buildToolDepError "filepath")))
        (hsPkgs.buildPackages.process or (pkgs.buildPackages.process or (errorHandler.buildToolDepError "process")))
        ];
      detailLevel = "FullDetails";
      licenseFiles = [ "LICENSE" ];
      dataDir = "src/data";
      dataFiles = [
        "Agda.css"
        "agda.sty"
        "emacs-mode/*.el"
        "JS/agda-rts.js"
        "JS/biginteger.js"
        "JS/highlight-hover.js"
        "lib/prim/Agda/Builtin/Bool.agda"
        "lib/prim/Agda/Builtin/Char.agda"
        "lib/prim/Agda/Builtin/Char/Properties.agda"
        "lib/prim/Agda/Builtin/Coinduction.agda"
        "lib/prim/Agda/Builtin/Cubical/Path.agda"
        "lib/prim/Agda/Builtin/Cubical/Id.agda"
        "lib/prim/Agda/Builtin/Cubical/Sub.agda"
        "lib/prim/Agda/Builtin/Cubical/Glue.agda"
        "lib/prim/Agda/Builtin/Cubical/HCompU.agda"
        "lib/prim/Agda/Builtin/Equality.agda"
        "lib/prim/Agda/Builtin/Equality/Erase.agda"
        "lib/prim/Agda/Builtin/Equality/Rewrite.agda"
        "lib/prim/Agda/Builtin/Float.agda"
        "lib/prim/Agda/Builtin/Float/Properties.agda"
        "lib/prim/Agda/Builtin/FromNat.agda"
        "lib/prim/Agda/Builtin/FromNeg.agda"
        "lib/prim/Agda/Builtin/FromString.agda"
        "lib/prim/Agda/Builtin/IO.agda"
        "lib/prim/Agda/Builtin/Int.agda"
        "lib/prim/Agda/Builtin/List.agda"
        "lib/prim/Agda/Builtin/Maybe.agda"
        "lib/prim/Agda/Builtin/Nat.agda"
        "lib/prim/Agda/Builtin/Reflection.agda"
        "lib/prim/Agda/Builtin/Reflection/External.agda"
        "lib/prim/Agda/Builtin/Reflection/Properties.agda"
        "lib/prim/Agda/Builtin/Sigma.agda"
        "lib/prim/Agda/Builtin/Size.agda"
        "lib/prim/Agda/Builtin/Strict.agda"
        "lib/prim/Agda/Builtin/String.agda"
        "lib/prim/Agda/Builtin/String/Properties.agda"
        "lib/prim/Agda/Builtin/TrustMe.agda"
        "lib/prim/Agda/Builtin/Unit.agda"
        "lib/prim/Agda/Builtin/Word.agda"
        "lib/prim/Agda/Builtin/Word/Properties.agda"
        "lib/prim/Agda/Primitive.agda"
        "lib/prim/Agda/Primitive/Cubical.agda"
        "MAlonzo/src/MAlonzo/*.hs"
        "MAlonzo/src/MAlonzo/RTE/*.hs"
        "postprocess-latex.pl"
        ];
      extraSrcFiles = [
        "CHANGELOG.md"
        "README.md"
        "doc/release-notes/2.6.1.1.md"
        "doc/release-notes/2.6.1.md"
        "doc/release-notes/2.6.0.1.md"
        "doc/release-notes/2.6.0.md"
        "doc/release-notes/2.5.4.2.md"
        "doc/release-notes/2.5.4.1.md"
        "doc/release-notes/2.5.4.md"
        "doc/release-notes/2.5.3.md"
        "doc/release-notes/2.5.2.md"
        "doc/release-notes/2.5.1.2.md"
        "doc/release-notes/2.5.1.1.md"
        "doc/release-notes/2.5.1.md"
        "doc/release-notes/2.4.2.5.md"
        "doc/release-notes/2.4.2.4.md"
        "doc/release-notes/2.4.2.3.md"
        "doc/release-notes/2.4.2.2.md"
        "doc/release-notes/2.4.2.1.md"
        "doc/release-notes/2.4.2.md"
        "doc/release-notes/2.4.0.2.md"
        "doc/release-notes/2.4.0.1.md"
        "doc/release-notes/2.4.0.md"
        "doc/release-notes/2.3.2.2.md"
        "doc/release-notes/2.3.2.1.md"
        "doc/release-notes/2.3.2.md"
        "doc/release-notes/2.3.0.md"
        "doc/release-notes/2.2.10.md"
        "doc/release-notes/2.2.8.md"
        "doc/release-notes/2.2.6.md"
        "doc/release-notes/2.2.2.md"
        "doc/release-notes/2.2.4.md"
        "doc/release-notes/2.2.0.md"
        "stack-8.10.3.yaml"
        "stack-8.8.4.yaml"
        "stack-8.6.5.yaml"
        "stack-8.4.4.yaml"
        "stack-8.2.2.yaml"
        "stack-8.0.2.yaml"
        ];
      extraTmpFiles = [];
      extraDocFiles = [];
      };
    components = {
      "library" = {
        depends = (((((([
          (hsPkgs."aeson" or (errorHandler.buildDepError "aeson"))
          (hsPkgs."array" or (errorHandler.buildDepError "array"))
          (hsPkgs."async" or (errorHandler.buildDepError "async"))
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."bifunctors" or (errorHandler.buildDepError "bifunctors"))
          (hsPkgs."binary" or (errorHandler.buildDepError "binary"))
          (hsPkgs."blaze-html" or (errorHandler.buildDepError "blaze-html"))
          (hsPkgs."boxes" or (errorHandler.buildDepError "boxes"))
          (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
          (hsPkgs."case-insensitive" or (errorHandler.buildDepError "case-insensitive"))
          (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
          (hsPkgs."data-hash" or (errorHandler.buildDepError "data-hash"))
          (hsPkgs."deepseq" or (errorHandler.buildDepError "deepseq"))
          (hsPkgs."directory" or (errorHandler.buildDepError "directory"))
          (hsPkgs."edit-distance" or (errorHandler.buildDepError "edit-distance"))
          (hsPkgs."equivalence" or (errorHandler.buildDepError "equivalence"))
          (hsPkgs."exceptions" or (errorHandler.buildDepError "exceptions"))
          (hsPkgs."filepath" or (errorHandler.buildDepError "filepath"))
          (hsPkgs."gitrev" or (errorHandler.buildDepError "gitrev"))
          (hsPkgs."hashable" or (errorHandler.buildDepError "hashable"))
          (hsPkgs."hashtables" or (errorHandler.buildDepError "hashtables"))
          (hsPkgs."haskeline" or (errorHandler.buildDepError "haskeline"))
          (hsPkgs."monad-control" or (errorHandler.buildDepError "monad-control"))
          (hsPkgs."mtl" or (errorHandler.buildDepError "mtl"))
          (hsPkgs."murmur-hash" or (errorHandler.buildDepError "murmur-hash"))
          (hsPkgs."pretty" or (errorHandler.buildDepError "pretty"))
          (hsPkgs."process" or (errorHandler.buildDepError "process"))
          (hsPkgs."regex-tdfa" or (errorHandler.buildDepError "regex-tdfa"))
          (hsPkgs."split" or (errorHandler.buildDepError "split"))
          (hsPkgs."stm" or (errorHandler.buildDepError "stm"))
          (hsPkgs."strict" or (errorHandler.buildDepError "strict"))
          (hsPkgs."template-haskell" or (errorHandler.buildDepError "template-haskell"))
          (hsPkgs."time" or (errorHandler.buildDepError "time"))
          (hsPkgs."unordered-containers" or (errorHandler.buildDepError "unordered-containers"))
          (hsPkgs."uri-encode" or (errorHandler.buildDepError "uri-encode"))
          (hsPkgs."zlib" or (errorHandler.buildDepError "zlib"))
          ] ++ (pkgs.lib).optional (flags.enable-cluster-counting) (hsPkgs."text-icu" or (errorHandler.buildDepError "text-icu"))) ++ (pkgs.lib).optional (system.isWindows) (hsPkgs."Win32" or (errorHandler.buildDepError "Win32"))) ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).ge "8.6.4" && (compiler.isGhc && (compiler.version).lt "9.1")) (hsPkgs."transformers" or (errorHandler.buildDepError "transformers"))) ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).ge "8.4" && (compiler.isGhc && (compiler.version).lt "8.6.4")) (hsPkgs."transformers" or (errorHandler.buildDepError "transformers"))) ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).lt "8.4") (hsPkgs."transformers" or (errorHandler.buildDepError "transformers"))) ++ [
          (hsPkgs."text" or (errorHandler.buildDepError "text"))
          ]) ++ (pkgs.lib).optional (compiler.isGhc && (compiler.version).ge "8.4") (hsPkgs."ghc-compact" or (errorHandler.buildDepError "ghc-compact"));
        build-tools = [
          (hsPkgs.buildPackages.alex or (pkgs.buildPackages.alex or (errorHandler.buildToolDepError "alex")))
          (hsPkgs.buildPackages.happy or (pkgs.buildPackages.happy or (errorHandler.buildToolDepError "happy")))
          ] ++ (pkgs.lib).optional (flags.cpphs) (hsPkgs.buildPackages.cpphs or (pkgs.buildPackages.cpphs or (errorHandler.buildToolDepError "cpphs")));
        buildable = (if compiler.isGhc && (compiler.version).eq "8.6.1"
          then false
          else true) && (if system.isWindows && (compiler.isGhc && (compiler.version).eq "8.6.3")
          then false
          else true);
        modules = [
          "Paths_Agda"
          "Agda/Interaction/Highlighting/Dot/Backend"
          "Agda/Interaction/Highlighting/Dot/Base"
          "Agda/Interaction/Highlighting/HTML/Backend"
          "Agda/Interaction/Highlighting/HTML/Base"
          "Agda/Interaction/Highlighting/LaTeX/Backend"
          "Agda/Interaction/Highlighting/LaTeX/Base"
          "Agda/Interaction/Options/Base"
          "Agda/Interaction/Options/HasOptions"
          "Agda/Utils/CallStack/Base"
          "Agda/Utils/CallStack/Pretty"
          "Agda/Auto/Auto"
          "Agda/Auto/Options"
          "Agda/Auto/CaseSplit"
          "Agda/Auto/Convert"
          "Agda/Auto/NarrowingSearch"
          "Agda/Auto/SearchControl"
          "Agda/Auto/Syntax"
          "Agda/Auto/Typecheck"
          "Agda/Benchmarking"
          "Agda/Compiler/Backend"
          "Agda/Compiler/Builtin"
          "Agda/Compiler/CallCompiler"
          "Agda/Compiler/Common"
          "Agda/Compiler/JS/Compiler"
          "Agda/Compiler/JS/Syntax"
          "Agda/Compiler/JS/Substitution"
          "Agda/Compiler/JS/Pretty"
          "Agda/Compiler/MAlonzo/Coerce"
          "Agda/Compiler/MAlonzo/Compiler"
          "Agda/Compiler/MAlonzo/Encode"
          "Agda/Compiler/MAlonzo/HaskellTypes"
          "Agda/Compiler/MAlonzo/Misc"
          "Agda/Compiler/MAlonzo/Pragmas"
          "Agda/Compiler/MAlonzo/Pretty"
          "Agda/Compiler/MAlonzo/Primitives"
          "Agda/Compiler/ToTreeless"
          "Agda/Compiler/Treeless/AsPatterns"
          "Agda/Compiler/Treeless/Builtin"
          "Agda/Compiler/Treeless/Compare"
          "Agda/Compiler/Treeless/EliminateDefaults"
          "Agda/Compiler/Treeless/EliminateLiteralPatterns"
          "Agda/Compiler/Treeless/Erase"
          "Agda/Compiler/Treeless/GuardsToPrims"
          "Agda/Compiler/Treeless/Identity"
          "Agda/Compiler/Treeless/NormalizeNames"
          "Agda/Compiler/Treeless/Pretty"
          "Agda/Compiler/Treeless/Simplify"
          "Agda/Compiler/Treeless/Subst"
          "Agda/Compiler/Treeless/Uncase"
          "Agda/Compiler/Treeless/Unused"
          "Agda/ImpossibleTest"
          "Agda/Interaction/AgdaTop"
          "Agda/Interaction/Base"
          "Agda/Interaction/BasicOps"
          "Agda/Interaction/SearchAbout"
          "Agda/Interaction/CommandLine"
          "Agda/Interaction/EmacsCommand"
          "Agda/Interaction/EmacsTop"
          "Agda/Interaction/ExitCode"
          "Agda/Interaction/JSONTop"
          "Agda/Interaction/JSON"
          "Agda/Interaction/FindFile"
          "Agda/Interaction/Highlighting/Common"
          "Agda/Interaction/Highlighting/Dot"
          "Agda/Interaction/Highlighting/Emacs"
          "Agda/Interaction/Highlighting/FromAbstract"
          "Agda/Interaction/Highlighting/Generate"
          "Agda/Interaction/Highlighting/HTML"
          "Agda/Interaction/Highlighting/JSON"
          "Agda/Interaction/Highlighting/Precise"
          "Agda/Interaction/Highlighting/Range"
          "Agda/Interaction/Highlighting/Vim"
          "Agda/Interaction/Highlighting/LaTeX"
          "Agda/Interaction/Imports"
          "Agda/Interaction/InteractionTop"
          "Agda/Interaction/Response"
          "Agda/Interaction/MakeCase"
          "Agda/Interaction/Monad"
          "Agda/Interaction/Library"
          "Agda/Interaction/Library/Base"
          "Agda/Interaction/Library/Parse"
          "Agda/Interaction/Options"
          "Agda/Interaction/Options/Help"
          "Agda/Interaction/Options/Lenses"
          "Agda/Interaction/Options/Warnings"
          "Agda/Main"
          "Agda/Syntax/Abstract/Name"
          "Agda/Syntax/Abstract/Pattern"
          "Agda/Syntax/Abstract/PatternSynonyms"
          "Agda/Syntax/Abstract/Pretty"
          "Agda/Syntax/Abstract/Views"
          "Agda/Syntax/Abstract"
          "Agda/Syntax/Builtin"
          "Agda/Syntax/Common"
          "Agda/Syntax/Concrete/Attribute"
          "Agda/Syntax/Concrete/Definitions"
          "Agda/Syntax/Concrete/Definitions/Errors"
          "Agda/Syntax/Concrete/Definitions/Monad"
          "Agda/Syntax/Concrete/Definitions/Types"
          "Agda/Syntax/Concrete/Fixity"
          "Agda/Syntax/Concrete/Generic"
          "Agda/Syntax/Concrete/Glyph"
          "Agda/Syntax/Concrete/Name"
          "Agda/Syntax/Concrete/Operators/Parser"
          "Agda/Syntax/Concrete/Operators/Parser/Monad"
          "Agda/Syntax/Concrete/Operators"
          "Agda/Syntax/Concrete/Pattern"
          "Agda/Syntax/Concrete/Pretty"
          "Agda/Syntax/Concrete"
          "Agda/Syntax/DoNotation"
          "Agda/Syntax/Fixity"
          "Agda/Syntax/IdiomBrackets"
          "Agda/Syntax/Info"
          "Agda/Syntax/Internal"
          "Agda/Syntax/Internal/Blockers"
          "Agda/Syntax/Internal/Defs"
          "Agda/Syntax/Internal/Elim"
          "Agda/Syntax/Internal/Generic"
          "Agda/Syntax/Internal/MetaVars"
          "Agda/Syntax/Internal/Names"
          "Agda/Syntax/Internal/Pattern"
          "Agda/Syntax/Internal/SanityCheck"
          "Agda/Syntax/Literal"
          "Agda/Syntax/Notation"
          "Agda/Syntax/Parser/Alex"
          "Agda/Syntax/Parser/Comments"
          "Agda/Syntax/Parser/Layout"
          "Agda/Syntax/Parser/LexActions"
          "Agda/Syntax/Parser/Lexer"
          "Agda/Syntax/Parser/Literate"
          "Agda/Syntax/Parser/LookAhead"
          "Agda/Syntax/Parser/Monad"
          "Agda/Syntax/Parser/Parser"
          "Agda/Syntax/Parser/StringLiterals"
          "Agda/Syntax/Parser/Tokens"
          "Agda/Syntax/Parser"
          "Agda/Syntax/Position"
          "Agda/Syntax/Reflected"
          "Agda/Syntax/Scope/Base"
          "Agda/Syntax/Scope/Monad"
          "Agda/Syntax/Translation/AbstractToConcrete"
          "Agda/Syntax/Translation/ConcreteToAbstract"
          "Agda/Syntax/Translation/InternalToAbstract"
          "Agda/Syntax/Translation/ReflectedToAbstract"
          "Agda/Syntax/Treeless"
          "Agda/Termination/CallGraph"
          "Agda/Termination/CallMatrix"
          "Agda/Termination/CutOff"
          "Agda/Termination/Monad"
          "Agda/Termination/Order"
          "Agda/Termination/RecCheck"
          "Agda/Termination/SparseMatrix"
          "Agda/Termination/Semiring"
          "Agda/Termination/TermCheck"
          "Agda/Termination/Termination"
          "Agda/TheTypeChecker"
          "Agda/TypeChecking/Abstract"
          "Agda/TypeChecking/CheckInternal"
          "Agda/TypeChecking/CompiledClause"
          "Agda/TypeChecking/CompiledClause/Compile"
          "Agda/TypeChecking/CompiledClause/Match"
          "Agda/TypeChecking/Constraints"
          "Agda/TypeChecking/Conversion"
          "Agda/TypeChecking/Conversion/Pure"
          "Agda/TypeChecking/Coverage"
          "Agda/TypeChecking/Coverage/Match"
          "Agda/TypeChecking/Coverage/SplitTree"
          "Agda/TypeChecking/Datatypes"
          "Agda/TypeChecking/DeadCode"
          "Agda/TypeChecking/DisplayForm"
          "Agda/TypeChecking/DropArgs"
          "Agda/TypeChecking/Empty"
          "Agda/TypeChecking/EtaContract"
          "Agda/TypeChecking/EtaExpand"
          "Agda/TypeChecking/Errors"
          "Agda/TypeChecking/Free"
          "Agda/TypeChecking/Free/Lazy"
          "Agda/TypeChecking/Free/Precompute"
          "Agda/TypeChecking/Free/Reduce"
          "Agda/TypeChecking/Forcing"
          "Agda/TypeChecking/Functions"
          "Agda/TypeChecking/Generalize"
          "Agda/TypeChecking/IApplyConfluence"
          "Agda/TypeChecking/Implicit"
          "Agda/TypeChecking/Injectivity"
          "Agda/TypeChecking/Inlining"
          "Agda/TypeChecking/InstanceArguments"
          "Agda/TypeChecking/Irrelevance"
          "Agda/TypeChecking/Level"
          "Agda/TypeChecking/LevelConstraints"
          "Agda/TypeChecking/Lock"
          "Agda/TypeChecking/Level/Solve"
          "Agda/TypeChecking/MetaVars"
          "Agda/TypeChecking/MetaVars/Mention"
          "Agda/TypeChecking/MetaVars/Occurs"
          "Agda/TypeChecking/Monad/Base"
          "Agda/TypeChecking/Monad/Benchmark"
          "Agda/TypeChecking/Monad/Builtin"
          "Agda/TypeChecking/Monad/Caching"
          "Agda/TypeChecking/Monad/Closure"
          "Agda/TypeChecking/Monad/Constraints"
          "Agda/TypeChecking/Monad/Context"
          "Agda/TypeChecking/Monad/Debug"
          "Agda/TypeChecking/Monad/Env"
          "Agda/TypeChecking/Monad/Imports"
          "Agda/TypeChecking/Monad/MetaVars"
          "Agda/TypeChecking/Monad/Mutual"
          "Agda/TypeChecking/Monad/Open"
          "Agda/TypeChecking/Monad/Options"
          "Agda/TypeChecking/Monad/Pure"
          "Agda/TypeChecking/Monad/Signature"
          "Agda/TypeChecking/Monad/SizedTypes"
          "Agda/TypeChecking/Monad/State"
          "Agda/TypeChecking/Monad/Statistics"
          "Agda/TypeChecking/Monad/Trace"
          "Agda/TypeChecking/Monad"
          "Agda/TypeChecking/Names"
          "Agda/TypeChecking/Patterns/Abstract"
          "Agda/TypeChecking/Patterns/Internal"
          "Agda/TypeChecking/Patterns/Match"
          "Agda/TypeChecking/Polarity"
          "Agda/TypeChecking/Positivity"
          "Agda/TypeChecking/Positivity/Occurrence"
          "Agda/TypeChecking/Pretty"
          "Agda/TypeChecking/Pretty/Call"
          "Agda/TypeChecking/Pretty/Constraint"
          "Agda/TypeChecking/Pretty/Warning"
          "Agda/TypeChecking/Primitive"
          "Agda/TypeChecking/Primitive/Base"
          "Agda/TypeChecking/Primitive/Cubical"
          "Agda/TypeChecking/ProjectionLike"
          "Agda/TypeChecking/Quote"
          "Agda/TypeChecking/ReconstructParameters"
          "Agda/TypeChecking/RecordPatterns"
          "Agda/TypeChecking/Records"
          "Agda/TypeChecking/Reduce"
          "Agda/TypeChecking/Reduce/Fast"
          "Agda/TypeChecking/Reduce/Monad"
          "Agda/TypeChecking/Rewriting"
          "Agda/TypeChecking/Rewriting/Clause"
          "Agda/TypeChecking/Rewriting/Confluence"
          "Agda/TypeChecking/Rewriting/NonLinMatch"
          "Agda/TypeChecking/Rewriting/NonLinPattern"
          "Agda/TypeChecking/Rules/Application"
          "Agda/TypeChecking/Rules/Builtin"
          "Agda/TypeChecking/Rules/Builtin/Coinduction"
          "Agda/TypeChecking/Rules/Data"
          "Agda/TypeChecking/Rules/Decl"
          "Agda/TypeChecking/Rules/Def"
          "Agda/TypeChecking/Rules/Display"
          "Agda/TypeChecking/Rules/LHS"
          "Agda/TypeChecking/Rules/LHS/Implicit"
          "Agda/TypeChecking/Rules/LHS/Problem"
          "Agda/TypeChecking/Rules/LHS/ProblemRest"
          "Agda/TypeChecking/Rules/LHS/Unify"
          "Agda/TypeChecking/Rules/Record"
          "Agda/TypeChecking/Rules/Term"
          "Agda/TypeChecking/Serialise"
          "Agda/TypeChecking/Serialise/Base"
          "Agda/TypeChecking/Serialise/Instances"
          "Agda/TypeChecking/Serialise/Instances/Abstract"
          "Agda/TypeChecking/Serialise/Instances/Common"
          "Agda/TypeChecking/Serialise/Instances/Compilers"
          "Agda/TypeChecking/Serialise/Instances/Highlighting"
          "Agda/TypeChecking/Serialise/Instances/Internal"
          "Agda/TypeChecking/Serialise/Instances/Errors"
          "Agda/TypeChecking/SizedTypes"
          "Agda/TypeChecking/SizedTypes/Solve"
          "Agda/TypeChecking/SizedTypes/Syntax"
          "Agda/TypeChecking/SizedTypes/Utils"
          "Agda/TypeChecking/SizedTypes/WarshallSolver"
          "Agda/TypeChecking/Sort"
          "Agda/TypeChecking/Substitute"
          "Agda/TypeChecking/Substitute/Class"
          "Agda/TypeChecking/Substitute/DeBruijn"
          "Agda/TypeChecking/SyntacticEquality"
          "Agda/TypeChecking/Telescope"
          "Agda/TypeChecking/Telescope/Path"
          "Agda/TypeChecking/Unquote"
          "Agda/TypeChecking/Warnings"
          "Agda/TypeChecking/With"
          "Agda/Utils/AffineHole"
          "Agda/Utils/Applicative"
          "Agda/Utils/AssocList"
          "Agda/Utils/Bag"
          "Agda/Utils/Benchmark"
          "Agda/Utils/BiMap"
          "Agda/Utils/CallStack"
          "Agda/Utils/Cluster"
          "Agda/Utils/Empty"
          "Agda/Utils/Environment"
          "Agda/Utils/Either"
          "Agda/Utils/Fail"
          "Agda/Utils/Favorites"
          "Agda/Utils/FileName"
          "Agda/Utils/Float"
          "Agda/Utils/Functor"
          "Agda/Utils/Function"
          "Agda/Utils/Graph/AdjacencyMap/Unidirectional"
          "Agda/Utils/Graph/TopSort"
          "Agda/Utils/Hash"
          "Agda/Utils/Haskell/Syntax"
          "Agda/Utils/Impossible"
          "Agda/Utils/IndexedList"
          "Agda/Utils/IntSet/Infinite"
          "Agda/Utils/IO"
          "Agda/Utils/IO/Binary"
          "Agda/Utils/IO/Directory"
          "Agda/Utils/IO/TempFile"
          "Agda/Utils/IO/UTF8"
          "Agda/Utils/IORef"
          "Agda/Utils/Lens"
          "Agda/Utils/Lens/Examples"
          "Agda/Utils/List"
          "Agda/Utils/List1"
          "Agda/Utils/List2"
          "Agda/Utils/ListT"
          "Agda/Utils/Map"
          "Agda/Utils/Maybe"
          "Agda/Utils/Maybe/Strict"
          "Agda/Utils/Memo"
          "Agda/Utils/Monad"
          "Agda/Utils/Monoid"
          "Agda/Utils/Null"
          "Agda/Utils/Parser/MemoisedCPS"
          "Agda/Utils/PartialOrd"
          "Agda/Utils/Permutation"
          "Agda/Utils/Pointer"
          "Agda/Utils/POMonoid"
          "Agda/Utils/Pretty"
          "Agda/Utils/SemiRing"
          "Agda/Utils/Semigroup"
          "Agda/Utils/Singleton"
          "Agda/Utils/Size"
          "Agda/Utils/SmallSet"
          "Agda/Utils/String"
          "Agda/Utils/Suffix"
          "Agda/Utils/Three"
          "Agda/Utils/Time"
          "Agda/Utils/Trie"
          "Agda/Utils/Tuple"
          "Agda/Utils/TypeLevel"
          "Agda/Utils/TypeLits"
          "Agda/Utils/Update"
          "Agda/Utils/VarSet"
          "Agda/Utils/Warshall"
          "Agda/Utils/WithDefault"
          "Agda/Utils/Zipper"
          "Agda/Version"
          "Agda/VersionCommit"
          ];
        hsSourceDirs = [ "src/full" ];
        };
      exes = {
        "agda" = {
          depends = [
            (hsPkgs."Agda" or (errorHandler.buildDepError "Agda"))
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            ];
          buildable = true;
          hsSourceDirs = [ "src/main" ];
          mainPath = [ "Main.hs" ];
          };
        "agda-mode" = {
          depends = [
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."directory" or (errorHandler.buildDepError "directory"))
            (hsPkgs."filepath" or (errorHandler.buildDepError "filepath"))
            (hsPkgs."process" or (errorHandler.buildDepError "process"))
            ];
          buildable = true;
          modules = [ "Paths_Agda" ];
          hsSourceDirs = [ "src/agda-mode" ];
          mainPath = [ "Main.hs" ];
          };
        };
      tests = {
        "agda-tests" = {
          depends = [
            (hsPkgs."Agda" or (errorHandler.buildDepError "Agda"))
            (hsPkgs."array" or (errorHandler.buildDepError "array"))
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
            (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
            (hsPkgs."directory" or (errorHandler.buildDepError "directory"))
            (hsPkgs."filepath" or (errorHandler.buildDepError "filepath"))
            (hsPkgs."filemanip" or (errorHandler.buildDepError "filemanip"))
            (hsPkgs."ieee754" or (errorHandler.buildDepError "ieee754"))
            (hsPkgs."monad-control" or (errorHandler.buildDepError "monad-control"))
            (hsPkgs."mtl" or (errorHandler.buildDepError "mtl"))
            (hsPkgs."process" or (errorHandler.buildDepError "process"))
            (hsPkgs."process-extras" or (errorHandler.buildDepError "process-extras"))
            (hsPkgs."QuickCheck" or (errorHandler.buildDepError "QuickCheck"))
            (hsPkgs."regex-tdfa" or (errorHandler.buildDepError "regex-tdfa"))
            (hsPkgs."tasty" or (errorHandler.buildDepError "tasty"))
            (hsPkgs."tasty-hunit" or (errorHandler.buildDepError "tasty-hunit"))
            (hsPkgs."tasty-quickcheck" or (errorHandler.buildDepError "tasty-quickcheck"))
            (hsPkgs."tasty-silver" or (errorHandler.buildDepError "tasty-silver"))
            (hsPkgs."temporary" or (errorHandler.buildDepError "temporary"))
            (hsPkgs."unix-compat" or (errorHandler.buildDepError "unix-compat"))
            (hsPkgs."uri-encode" or (errorHandler.buildDepError "uri-encode"))
            ] ++ [ (hsPkgs."text" or (errorHandler.buildDepError "text")) ];
          buildable = (if compiler.isGhc && (compiler.version).eq "8.6.1"
            then false
            else true) && (if system.isWindows && (compiler.isGhc && (compiler.version).eq "8.6.3")
            then false
            else true);
          modules = [
            "Bugs/Tests"
            "Compiler/Tests"
            "Fail/Tests"
            "Interactive/Tests"
            "Internal/Compiler/MAlonzo/Encode"
            "Internal/Helpers"
            "Internal/Interaction/Highlighting/Precise"
            "Internal/Interaction/Highlighting/Range"
            "Internal/Interaction/Library"
            "Internal/Interaction/Options"
            "Internal/Syntax/Abstract/Name"
            "Internal/Syntax/Common"
            "Internal/Syntax/Concrete/Name"
            "Internal/Syntax/Internal"
            "Internal/Syntax/Parser/Parser"
            "Internal/Syntax/Position"
            "Internal/Termination/CallGraph"
            "Internal/Termination/CallMatrix"
            "Internal/Termination/Order"
            "Internal/Termination/Semiring"
            "Internal/Termination/SparseMatrix"
            "Internal/Termination/Termination"
            "Internal/Tests"
            "Internal/TypeChecking"
            "Internal/TypeChecking/Free"
            "Internal/TypeChecking/Free/Lazy"
            "Internal/TypeChecking/Generators"
            "Internal/TypeChecking/Irrelevance"
            "Internal/TypeChecking/Monad/Base"
            "Internal/TypeChecking/Positivity"
            "Internal/TypeChecking/Positivity/Occurrence"
            "Internal/TypeChecking/Rules/LHS/Problem"
            "Internal/TypeChecking/SizedTypes"
            "Internal/TypeChecking/SizedTypes/Syntax"
            "Internal/TypeChecking/SizedTypes/WarshallSolver"
            "Internal/TypeChecking/Substitute"
            "Internal/Utils/AssocList"
            "Internal/Utils/Bag"
            "Internal/Utils/BiMap"
            "Internal/Utils/Cluster"
            "Internal/Utils/Either"
            "Internal/Utils/Favorites"
            "Internal/Utils/FileName"
            "Internal/Utils/Graph/AdjacencyMap/Unidirectional"
            "Internal/Utils/IntSet"
            "Internal/Utils/List"
            "Internal/Utils/ListT"
            "Internal/Utils/Maybe/Strict"
            "Internal/Utils/Monoid"
            "Internal/Utils/NonEmptyList"
            "Internal/Utils/PartialOrd"
            "Internal/Utils/Permutation"
            "Internal/Utils/SmallSet"
            "Internal/Utils/Three"
            "Internal/Utils/Trie"
            "Internal/Utils/Warshall"
            "LaTeXAndHTML/Tests"
            "LibSucceed/Tests"
            "Succeed/Tests"
            "UserManual/Tests"
            "Utils"
            ];
          hsSourceDirs = [ "test/" ];
          mainPath = [ "Main.hs" ];
          };
        };
      };
    } // rec { src = (pkgs.lib).mkDefault ../.; }