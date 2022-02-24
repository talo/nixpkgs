{ buildPythonPackage, fetchurl, cudatoolkit_11, pytest-runner, pytorch-bin
, which, ninja }:

buildPythonPackage {
  pname = "torch-spline-conv";
  version = "1.2.1";
  src = fetchurl {
    url =
      "https://files.pythonhosted.org/packages/80/f8/4d010376565c59b3c397b1cf103edc4e9b2ed087c2bbd3677f0a92930d75/torch_spline_conv-1.2.1.tar.gz";
    sha256 = "0f5lk8bcz1pr3dd3sqqsq52gq8p0acardhi8lxim4k6b1s76akrn";
  };
  preConfigure = ''
    export TORCH_CUDA_ARCH_LIST="8.6 8.6+PTX"
    export CPATH=${cudatoolkit_11}/include
    export LD_LIBRARY_PATH=$${cudatoolkit_11}/lib
    export CUDA_HOME=${cudatoolkit_11}
    export FORCE_CUDA="1"
  '';
  format = "setuptools";
  doCheck = false;
  enableParallelBuilding = true;
  buildInputs = [ cudatoolkit_11 ];
  #cudatoolkit_11_joined ];
  checkInputs = [ ];
  nativeBuildInputs = [ pytest-runner which ninja ];
  propagatedBuildInputs = [ pytorch-bin ];
}
