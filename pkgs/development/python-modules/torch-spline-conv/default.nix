{ buildPythonPackage, fetchurl, cudaPackages_11_3, pytest-runner, pytorch-bin
, which, ninja }:

with cudaPackages_11_3;
buildPythonPackage {
  pname = "torch-spline-conv";
  version = "1.2.1";
  format = "wheel";
  #format = "setuptools";
  src = fetchurl {
    url =
      "https://data.pyg.org/whl/torch-1.11.0%2Bcu113/torch_spline_conv-1.2.1-cp39-cp39-linux_x86_64.whl";
    sha256 = "sha256-muH3slNLr2p2F6kJ5cHLNAWGT/LgeX5QmY2zVbcJmcI=";
    # url =
    #  "https://data.pyg.org/whl/torch-1.11.0%2Bcu115/torch_spline_conv-1.2.1-cp39-cp39-linux_x86_64.whl";
    #sha256 = "sha256-vsOreU1ryWVTZ++NNG4/UjHOyWxwhwkqwFZbwR7XkLA=";
    # url =
    #   "https://files.pythonhosted.org/packages/80/f8/4d010376565c59b3c397b1cf103edc4e9b2ed087c2bbd3677f0a92930d75/torch_spline_conv-1.2.1.tar.gz";
    # sha256 = "sha256-Nk9ljg7LTFJjpyjClhVT4CL8RMEaYz1aG/mGzxaatDg=";
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
  doCheck = false;
  #enableParallelBuilding = true;
  #buildInputs = [ cudatoolkit pytorch-bin ];
  #cudatoolkit_11_joined ];
  checkInputs = [ ];
  nativeBuildInputs = [ cudatoolkit pytest-runner which ];
}
