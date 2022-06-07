{ python, cudaPackages_11_3, which, fetchurl, scipy, torch-spline-conv
, pytorch-bin, pytest-runner, ninja }:

with cudaPackages_11_3;
python.pkgs.buildPythonPackage rec {
  pname = "torch-sparse";
  version = "0.6.13";
  src = fetchurl {
    url =
      "https://data.pyg.org/whl/torch-1.11.0%2Bcu115/torch_sparse-0.6.13-cp39-cp39-linux_x86_64.whl";
    sha256 = "sha256-TR9F9ihZmNI3c4NKq1ICI9HcqqEZl1j8MM/jw5eiQcM=";
    # url =
    #   #"https://github.com/rusty1s/pytorch_sparse/archive/refs/heads/master.tar.gz";
    #   "https://github.com/rusty1s/pytorch_sparse/archive/adc8be24bd391b3c61a8a44e655f585e12943893.tar.gz";
    # #"https://files.pythonhosted.org/packages/ee/44/b4a1d6d7fa67309781005c0e36723dd0bd745fc1a20c9330796055953b10/torch_sparse-0.6.13.tar.gz";
    # sha256 = "sha256-nwg8il9pLsk8K1gd2uJEPx36ux5aVeu+UCKlHYCDkYs=";
  };
  # makeFlags = [
  #   "CUDA_HOME=${cudatoolkit}"
  #   #"PREFIX=$(out)"
  # ];
  preConfigure = ''
    export TORCH_CUDA_ARCH_LIST="8.0 8.0+PTX 8.6 8.6+PTX"
    export CUDA_HOME=${cudatoolkit}
    export FORCE_CUDA="1"
    #export MAX_JOBS=$NIX_BUILD_CORES
  '';
  format = "wheel";
  doCheck = false;
  enableParallelBuilding = true;
  buildInputs = [ which pytest-runner cudatoolkit pytorch-bin ];
  checkInputs = [ ];
  nativeBuildInputs = [ which cudatoolkit ];
  propagatedBuildInputs = [ scipy torch-spline-conv ];
}
