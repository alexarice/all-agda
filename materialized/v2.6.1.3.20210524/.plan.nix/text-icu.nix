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
    flags = {};
    package = {
      specVersion = "1.10";
      identifier = { name = "text-icu"; version = "0.7.1.0"; };
      license = "BSD-3-Clause";
      copyright = "2009-2015 Bryan O'Sullivan";
      maintainer = "Bryan O'Sullivan <bos@serpentine.com>";
      author = "";
      homepage = "https://github.com/bos/text-icu";
      url = "";
      synopsis = "Bindings to the ICU library";
      description = "Haskell bindings to the International Components for Unicode (ICU)\nlibraries.  These libraries provide robust and full-featured Unicode\nservices on a wide variety of platforms.\n\nFeatures include:\n\n* Both pure and impure bindings, to allow for fine control over efficiency\nand ease of use.\n\n* Breaking of strings on character, word, sentence, and line boundaries.\n\n* Access to the Unicode Character Database (UCD) of character metadata.\n\n* String collation functions, for locales where the conventions for\nlexicographic ordering differ from the simple numeric ordering of\ncharacter codes.\n\n* Character set conversion functions, allowing conversion between\nUnicode and over 220 character encodings.\n\n* Unicode normalization.  (When implementations keep strings in a\nnormalized form, they can be assured that equivalent strings have a\nunique binary representation.)\n\n* Regular expression search and replace.\n\n* Security checks for visually confusable (spoofable) strings.";
      buildType = "Simple";
      isLocal = true;
      detailLevel = "FullDetails";
      licenseFiles = [ "LICENSE" ];
      dataDir = ".";
      dataFiles = [];
      extraSrcFiles = [
        "README.markdown"
        "benchmarks/Breaker.hs"
        "changelog.md"
        "include/hs_text_icu.h"
        ];
      extraTmpFiles = [];
      extraDocFiles = [];
      };
    components = {
      "library" = {
        depends = [
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
          (hsPkgs."deepseq" or (errorHandler.buildDepError "deepseq"))
          (hsPkgs."text" or (errorHandler.buildDepError "text"))
          ];
        libs = [
          (pkgs."icuuc" or (errorHandler.sysDepError "icuuc"))
          ] ++ (if system.isWindows
          then [
            (pkgs."icuin" or (errorHandler.sysDepError "icuin"))
            (pkgs."icudt" or (errorHandler.sysDepError "icudt"))
            ]
          else [
            (pkgs."icui18n" or (errorHandler.sysDepError "icui18n"))
            (pkgs."icudata" or (errorHandler.sysDepError "icudata"))
            ]);
        buildable = true;
        modules = [
          "Data/Text/ICU/BitMask"
          "Data/Text/ICU/Break/Pure"
          "Data/Text/ICU/Break/Types"
          "Data/Text/ICU/Collate/Internal"
          "Data/Text/ICU/Collate/Pure"
          "Data/Text/ICU/Convert/Internal"
          "Data/Text/ICU/Error/Internal"
          "Data/Text/ICU/Internal"
          "Data/Text/ICU/Iterator"
          "Data/Text/ICU/Normalize/Internal"
          "Data/Text/ICU/Regex/Internal"
          "Data/Text/ICU/Regex/Pure"
          "Data/Text/ICU/Spoof/Internal"
          "Data/Text/ICU/Spoof/Pure"
          "Data/Text/ICU/Text"
          "Data/Text/ICU"
          "Data/Text/ICU/Break"
          "Data/Text/ICU/Char"
          "Data/Text/ICU/Collate"
          "Data/Text/ICU/Convert"
          "Data/Text/ICU/Error"
          "Data/Text/ICU/Normalize"
          "Data/Text/ICU/Regex"
          "Data/Text/ICU/Spoof"
          "Data/Text/ICU/Types"
          ];
        cSources = [ "cbits/text_icu.c" ];
        includeDirs = [
          "include"
          ] ++ (pkgs.lib).optional (system.isOsx) "/usr/local/opt/icu4c/include";
        };
      tests = {
        "tests" = {
          depends = [
            (hsPkgs."HUnit" or (errorHandler.buildDepError "HUnit"))
            (hsPkgs."QuickCheck" or (errorHandler.buildDepError "QuickCheck"))
            (hsPkgs."array" or (errorHandler.buildDepError "array"))
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
            (hsPkgs."deepseq" or (errorHandler.buildDepError "deepseq"))
            (hsPkgs."directory" or (errorHandler.buildDepError "directory"))
            (hsPkgs."ghc-prim" or (errorHandler.buildDepError "ghc-prim"))
            (hsPkgs."random" or (errorHandler.buildDepError "random"))
            (hsPkgs."test-framework" or (errorHandler.buildDepError "test-framework"))
            (hsPkgs."test-framework-hunit" or (errorHandler.buildDepError "test-framework-hunit"))
            (hsPkgs."test-framework-quickcheck2" or (errorHandler.buildDepError "test-framework-quickcheck2"))
            (hsPkgs."text" or (errorHandler.buildDepError "text"))
            (hsPkgs."text-icu" or (errorHandler.buildDepError "text-icu"))
            ];
          buildable = true;
          modules = [ "Properties" "QuickCheckUtils" ];
          hsSourceDirs = [ "tests" ];
          mainPath = [ "Tests.hs" ];
          };
        };
      };
    } // rec { src = (pkgs.lib).mkDefault .././.source-repository-packages/0; }