{
  python,
  which,
  fetchurl,
  scipy,
  torch-spline-conv,
  pytest-runner,
  ninja,
}: let
  pyVerNoDot = builtins.replaceStrings ["."] [""] python.pythonVersion;
  hashes = {
    py39 = {
      url = "https://data.pyg.org/whl/torch-1.11.0%2Bcu115/torch_sparse-0.6.13-cp39-cp39-linux_x86_64.whl";
      sha256 = "sha256-TR9F9ihZmNI3c4NKq1ICI9HcqqEZl1j8MM/jw5eiQcM=";
    };
    py310 = {
      url = "https://data.pyg.org/whl/torch-1.12.0%2Bcu116/torch_sparse-0.6.14-cp310-cp310-linux_x86_64.whl";
      sha256 = "sha256-F2VhAHF/N0OKafvNC+eTApJJgrg5pRWQNMy7Bu4FrKs=";
    };
  };
in
  python.pkgs.buildPythonPackage rec {
    pname = "torch-sparse";
    version = "0.6.13";
    src = fetchurl hashes."py${pyVerNoDot}";
    format = "wheel";
    doCheck = false;
    enableParallelBuilding = true;
    propagatedBuildInputs = [scipy torch-spline-conv];
  }
