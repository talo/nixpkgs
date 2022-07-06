{
  stdenv,
  cmake,
  fetchFromGitHub,
  git,
  opencl-headers,
  doxygen,
  swig,
  python3,
}:
stdenv.mkDerivation rec {
  pname = "openmm";
  version = "develop";
  src = fetchFromGitHub {
    owner = "openmm";
    repo = "openmm";
    rev = "master";
    hash = "sha256-BDZowyF6YQO+Ci5F/HOgBLA8CIS0DeBGLJuCGWapU70=";
  };
  buildInputs = [cmake git opencl-headers doxygen swig python3];
}
