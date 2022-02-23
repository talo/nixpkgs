{ buildPythonPackage, fetchurl, cudatoolkit_11, which, pytorch-bin
, pytest-runner }:

let cudatoolkit = cudatoolkit_11;
in buildPythonPackage {
  pname = "torch-cluster";
  version = "1.5.9";
  src = fetchurl {
    url =
      "https://files.pythonhosted.org/packages/4b/27/2f38017ae386ba27c13efe6a87eca7c3c58766c3117c86e0fa2c3f7562a9/torch_cluster-1.5.9.tar.gz";
    sha256 = "19fwb2k96j4bc6krbz2ds4i5crfqrp97vgqzx5zqwg077ygrw84n";
  };
  format = "setuptools";
  doCheck = false;
  preConfigure = ''
    export TORCH_CUDA_ARCH_LIST="8.6 8.6+PTX"
    export CPATH=${cudatoolkit}/include
    export LD_LIBRARY_PATH=$${cudatoolkit}/lib
    export CUDA_HOME=${cudatoolkit}
    export FORCE_CUDA="1"
  '';
  buildInputs = [ cudatoolkit pytorch-bin ];
  checkInputs = [ ];
  nativeBuildInputs = [ which pytorch-bin ];
  propagatedBuildInputs = [ pytest-runner pytorch-bin ];
}
