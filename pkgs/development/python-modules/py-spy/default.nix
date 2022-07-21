{  lib, pkgs, python, buildPythonPackage }:

buildPythonPackage {
  pname = "py-spy";
  version = "0.3.11";

  src = "${pkgs.py-spy}/lib/python${python.sourceVersion.major}.${python.sourceVersion.minor}/site-packages";

  nativeBuildInputs = [ pkgs.py-spy ];

  # these env variables are used by the bindings to find libraries
  # they need to be included explicitly in your nix-shell for
  # some functionality to work (inparticular, pybel).
  # see https://openbabel.org/docs/dev/Installation/install.html
  #BABEL_LIBDIR = "${openbabel}/lib/openbabel/3.1.0";
  LD_LIBRARY_PATH = "${pkgs.py-spy}/lib";

  pythonImportsCheck = [ "py_spy" ];

}
