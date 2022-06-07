{ buildPythonPackage, cudaPackages_11_3, fetchurl, torch-spline-conv, which
, pytest-runner, pytorch-bin, ninja }:

with cudaPackages_11_3;
buildPythonPackage {
  pname = "torch-scatter";
  version = "2.0.9";
  preConfigure = ''
    export TORCH_CUDA_ARCH_LIST="8.0 8.0+PTX 8.6 8.6+PTX"
    #export CUDA_HOME=${cudatoolkit}
    export FORCE_CUDA="1"
    export MAX_JOBS=$NIX_BUILD_CORES
  '';
  src = fetchurl {
    url =
      "https://data.pyg.org/whl/torch-1.11.0%2Bcu115/torch_scatter-2.0.9-cp39-cp39-linux_x86_64.whl";
    sha256 = "sha256-RrJ67McUpKGa07Xqhd1c0/1WZh7SD9aUapfq6Ec8tss=";
    # url =
    #   "https://files.pythonhosted.org/packages/1b/a0/6e44e887eb7fff78a9642035fe9662fc22c850a377369a52f308dd553104/torch_scatter-2.0.9.tar.gz";
    # sha256 = "1wd7fz291d1mp5rx6z0ay31bj29bvhv6n58xlzqasfs7chfm3x88";
  };
  format = "wheel";
  doCheck = false;

  enableParallelBuilding = true;

  buildInputs = [
    cudatoolkit

    torch-spline-conv
  ];
  nativeBuildInputs = [ which cudatoolkit ];
  checkInputs = [ ];
  #     buildHooks = "
  # LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${stdenv.cc.cc.lib}/lib/
  # ";
  propagatedBuildInputs = [ pytest-runner pytorch-bin ];
}
