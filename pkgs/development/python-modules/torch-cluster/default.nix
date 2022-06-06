{ buildPythonPackage, fetchurl, cudaPackages_11_5, which, pytorch-bin
, pytest-runner, ninja }:

let cudatoolkit = cudaPackages_11_5.cudatoolkit;
in buildPythonPackage {
  pname = "torch-cluster";
  version = "1.5.9";
  src = fetchurl {
    url =
      "https://github.com/rusty1s/pytorch_cluster/archive/refs/tags/1.5.9.tar.gz";
    #"https://files.pythonhosted.org/packages/4b/27/2f38017ae386ba27c13efe6a87eca7c3c58766c3117c86e0fa2c3f7562a9/torch_cluster-1.5.9.tar.gz";
    sha256 = "sha256-GbRnGlGekdM0WlmxASrwBHN74+fCFFp9wcyuUp+a51M=";
  };
  format = "setuptools";
  doCheck = false;
  enableParallelBuilding = true;
  preConfigure = ''
    export TORCH_CUDA_ARCH_LIST="8.0 8.0+PTX 8.6 8.6+PTX"
    export CUDA_HOME=${cudatoolkit}
    export FORCE_CUDA="1"
    export MAX_JOBS=$NIX_BUILD_CORES
  '';
  buildInputs = [ cudatoolkit pytorch-bin ];
  checkInputs = [ ];
  nativeBuildInputs = [ which pytorch-bin ninja ];
  propagatedBuildInputs = [ pytest-runner pytorch-bin ];
}
