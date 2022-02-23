{ buildPythonPackage, fetchurl, cudatoolkit, pytest-runner, pytorch-bin }:

buildPythonPackage rec {
  pname = "torch-spline-conv";
  version = "1.2.1";
  src = fetchurl {
    url =
      "https://files.pythonhosted.org/packages/80/f8/4d010376565c59b3c397b1cf103edc4e9b2ed087c2bbd3677f0a92930d75/torch_spline_conv-1.2.1.tar.gz";
    sha256 = "0f5lk8bcz1pr3dd3sqqsq52gq8p0acardhi8lxim4k6b1s76akrn";
  };
  preConfigure = ''
    export TORCH_CUDA_ARCH_LIST="8.6 8.6+PTX"
    export CPATH=${cudatoolkit}/include
    export LD_LIBRARY_PATH=$${cudatoolkit}/lib
    export CUDA_HOME=${cudatoolkit}
    export FORCE_CUDA="1"
  '';
  format = "setuptools";
  doCheck = false;
  buildInputs = [ cudatoolkit ];
  #cudatoolkit_joined ];
  checkInputs = [ ];
  nativeBuildInputs = [ pytest-runner ];
  propagatedBuildInputs = [ pytorch-bin ];
}
