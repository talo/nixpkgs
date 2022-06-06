{ python, cudaPackages_11_5, which, fetchurl, scipy, torch-spline-conv
, pytorch-bin, pytest-runner, ninja }:

with cudaPackages_11_5;
python.pkgs.buildPythonPackage rec {
  pname = "torch-sparse";
  version = "0.6.13";
  src = fetchurl {
    url =
      "https://files.pythonhosted.org/packages/ee/44/b4a1d6d7fa67309781005c0e36723dd0bd745fc1a20c9330796055953b10/torch_sparse-0.6.13.tar.gz";
    sha256 = "b4896822559f9b47d8b0186d74c94b7449f91db155a57d617fbeae9b722fa1f3";
  };
  makeFlags = [
    "CUDA_HOME=${cudatoolkit}"
    #"PREFIX=$(out)"
  ];
  preConfigure = ''
    export TORCH_CUDA_ARCH_LIST="8.0 8.0+PTX 8.6 8.6+PTX"
    export CUDA_HOME=${cudatoolkit}
    export FORCE_CUDA="1"
    export MAX_JOBS=$NIX_BUILD_CORES
  '';
  format = "setuptools";
  doCheck = false;
  enableParallelBuilding = true;
  buildInputs = [ which pytest-runner cudatoolkit ];
  checkInputs = [ ];
  nativeBuildInputs = [ which cudatoolkit ninja ];
  propagatedBuildInputs = [ scipy torch-spline-conv pytorch-bin ];
}
