{ buildPythonPackage, fetchurl, pytest-runner, which, ninja, python}:

let
  pyVerNoDot = builtins.replaceStrings [ "." ] [ "" ] python.pythonVersion;
  hashes = {
    py39 = {
    url =
      "https://data.pyg.org/whl/torch-1.11.0%2Bcu113/torch_spline_conv-1.2.1-cp39-cp39-linux_x86_64.whl";
    sha256 = "sha256-azbAx96DYSKgAclRrssIlJHdrtpisKXT0YDPcIN+lnw=";
    };
    py310 = {
    url =
      "https://data.pyg.org/whl/torch-1.12.0%2Bcu116/torch_spline_conv-1.2.1-cp310-cp310-linux_x86_64.whl";
    sha256 = "sha256-+sHbAy4Vlgse0O46r+x9eorlTrz8m9o/F1Qbp3mobEI=";
    };
  };
in buildPythonPackage {
  pname = "torch-spline-conv";
  version = "1.2.1";
  format = "wheel";
  src = fetchurl hashes."py${pyVerNoDot}";
  doCheck = false;
  checkInputs = [ ];
  nativeBuildInputs = [ pytest-runner which ];
}
