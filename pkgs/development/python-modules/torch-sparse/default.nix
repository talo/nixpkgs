{ python, cudatoolkit_11, which, fetchurl, scipy, torch-spline-conv, pytorch-bin
, pytest-runner, ninja }:

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
    export CPATH=${cudatoolkit_11}/bin
    export CUDA_HOME=${cudatoolkit_11}
    export FORCE_CUDA="1"
  '';
  format = "setuptools";
  doCheck = false;
  enableParallelBuilding = true;
  buildInputs = [ which pytest-runner cudatoolkit_11 ];
  checkInputs = [ ];
  nativeBuildInputs = [ which cudatoolkit_11 ninja ];
  propagatedBuildInputs = [ scipy torch-spline-conv pytorch-bin ];
}
