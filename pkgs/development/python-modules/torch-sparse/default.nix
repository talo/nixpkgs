{ python, which, fetchurl, scipy, torch-spline-conv, pytest-runner, ninja }:

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
  format = "wheel";
  doCheck = false;
  enableParallelBuilding = true;
  propagatedBuildInputs = [ scipy torch-spline-conv ];
}
