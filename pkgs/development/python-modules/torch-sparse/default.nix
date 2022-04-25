{ python, cudatoolkit_11, which, fetchurl, scipy, torch-spline-conv, pytorch-bin
, pytest-runner, ninja }:

python.pkgs.buildPythonPackage rec {
  pname = "torch-sparse";
  version = "0.6.13";
  src = fetchurl {
    url =
      "https://files.pythonhosted.org/packages/ee/44/b4a1d6d7fa67309781005c0e36723dd0bd745fc1a20c9330796055953b10/torch_sparse-0.6.13.tar.gz";
    sha256 = "b4896822559f9b47d8b0186d74c94b7449f91db155a57d617fbeae9b722fa1f3";
  };
  preConfigure = ''
    export TORCH_CUDA_ARCH_LIST="8.6 8.6+PTX"
    export CPATH=${cudatoolkit_11}/bin
    export CUDA_HOME=${cudatoolkit_11}
    export FORCE_CUDA="1"
    export MAX_JOBS=$NIX_BUILD_CORES
  '';
  format = "setuptools";
  doCheck = false;
  enableParallelBuilding = true;
  buildInputs = [ which pytest-runner cudatoolkit_11 ];
  checkInputs = [ ];
  nativeBuildInputs = [ which cudatoolkit_11 ninja ];
  propagatedBuildInputs = [ scipy torch-spline-conv pytorch-bin ];
}
