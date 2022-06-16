{ stdenv, boost, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "autodock-vina";
  version = "develop";
  src = fetchFromGitHub {
    owner = "ccsb-scripps";
    repo = "AutoDock-Vina";
    rev = version;
    sha256 = "sha256-bLTDpq3ohUP+KooPvhv1/AZfdo0HwB3g9QOuE2E/pmY=";
  };
  sourceRoot = "./build/linux/release";
  buildInputs = [ boost ];
}
