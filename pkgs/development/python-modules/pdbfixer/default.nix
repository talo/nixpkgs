{
  buildPythonPackage,
  fetchFromGitHub,
  numpy,
  openmm,
  setuptools,
}:
buildPythonPackage {
  #pkgs.stdenv.mkDerivation { #
  pname = "pdbfixer";
  version = "1.8.1";
  src = fetchFromGitHub {
    owner = "openmm";
    repo = "pdbfixer";
    rev = "v1.8.1";
    hash = "sha256-XrGP+hYi2+5Nw9nPJkmsCfiNO6Q6kENhG3LUjxEzVD8=";
  };
  doCheck = false;
  propagatedBuildInputs = [
    openmm
    setuptools
    numpy
  ];
}
