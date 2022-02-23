{ python, cudatoolkit, which, fetchurl, scipy, torch-spline-conv, pytorch-bin
, pytest-runner, ... }:

python.pkgs.buildPythonPackage rec {
  pname = "torch-sparse";
  version = "0.6.12";
  src = fetchurl {
    url =
      "https://files.pythonhosted.org/packages/00/40/208c5b8ae34c89403d9da648c9689465880539d95a4ad570ac9d6f301b72/torch_sparse-0.6.12.tar.gz";
    sha256 = "1lnfif0f594ws6n7xbai26rj2awn7d0y5iwkw15xwp458nyqbnw5";
  };
  preConfigure = ''
    export TORCH_CUDA_ARCH_LIST="8.6 8.6+PTX"
    export CPATH=${cudatoolkit}/bin
    export CUDA_HOME=${cudatoolkit}
    export FORCE_CUDA="1"
  '';
  format = "setuptools";
  doCheck = false;
  buildInputs = [ which pytest-runner cudatoolkit ];
  checkInputs = [ ];
  nativeBuildInputs = [ which cudatoolkit ];
  propagatedBuildInputs = [ scipy torch-spline-conv pytorch-bin ];
}
