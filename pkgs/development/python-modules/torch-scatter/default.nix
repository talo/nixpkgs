{ buildPythonPackage, cudaPackages_11_5, fetchurl, torch-spline-conv, which
, pytest-runner, pytorch-bin, ninja }:

with cudaPackages_11_5;
buildPythonPackage {
  pname = "torch-scatter";
  version = "2.0.9";
  preConfigure = ''
    export TORCH_CUDA_ARCH_LIST="8.0 8.0+PTX 8.6 8.6+PTX"
    export CPATH=${cudatoolkit}/bin
    export CUDA_HOME=${cudatoolkit}
    export FORCE_CUDA="1"
    export MAX_JOBS=$NIX_BUILD_CORES
  '';
  src = fetchurl {
    url =
      "https://files.pythonhosted.org/packages/1b/a0/6e44e887eb7fff78a9642035fe9662fc22c850a377369a52f308dd553104/torch_scatter-2.0.9.tar.gz";
    sha256 = "1wd7fz291d1mp5rx6z0ay31bj29bvhv6n58xlzqasfs7chfm3x88";
  };
  format = "setuptools";
  doCheck = false;

  enableParallelBuilding = true;

  buildInputs = [
    cudatoolkit

    torch-spline-conv
  ];
  nativeBuildInputs = [ which cudatoolkit ninja ];
  checkInputs = [ ];
  #     buildHooks = "
  # LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${stdenv.cc.cc.lib}/lib/
  # ";
  propagatedBuildInputs = [ pytest-runner pytorch-bin ];
}
