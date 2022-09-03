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
  pname = "OpenMM";
  version = "1dac981a63300a2a53a7925f570995914f7163ed";
  src = fetchFromGitHub {
    owner = "openmm";
    repo = "openmm";
    rev = "1dac981a63300a2a53a7925f570995914f7163ed";
    hash = "sha256-BDZowyF6YQO+Ci5F/HOgBLA8CIS0DeBGLJuCGWapU70=";
  };
  buildInputs = [cmake git opencl-headers doxygen swig python3];
}
