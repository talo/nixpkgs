{ buildPythonPackage, fetchurl, cudatoolkit_11, which, pytorch-bin
, pytest-runner, ninja }:

let cudatoolkit = cudatoolkit_11;
in buildPythonPackage {
  pname = "torch-cluster";
  version = "1.5.9";
  src = fetchurl {
    url =
      "https://github.com/rusty1s/pytorch_cluster/archive/refs/heads/master.tar.gz";
    #"https://files.pythonhosted.org/packages/4b/27/2f38017ae386ba27c13efe6a87eca7c3c58766c3117c86e0fa2c3f7562a9/torch_cluster-1.5.9.tar.gz";
    sha256 = "sha256-mjZALNY77Wy+3M7l8qkFADiZtI6ddA4BhXImT8m1C6Q=";
  };
  format = "setuptools";
  doCheck = false;
  enableParallelBuilding = true;
  preConfigure = ''
    export TORCH_CUDA_ARCH_LIST="8.6 8.6+PTX"
    export CPATH=${cudatoolkit}/include
    export LD_LIBRARY_PATH=$${cudatoolkit}/lib
    export CUDA_HOME=${cudatoolkit}
    export FORCE_CUDA="1"
    export MAX_JOBS=$NIX_BUILD_CORES
  '';
  buildInputs = [ cudatoolkit pytorch-bin ];
  checkInputs = [ ];
  nativeBuildInputs = [ which pytorch-bin ninja ];
  propagatedBuildInputs = [ pytest-runner pytorch-bin ];
}
