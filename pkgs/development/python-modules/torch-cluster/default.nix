{ buildPythonPackage, fetchurl, which, pytest-runner, ninja }:

buildPythonPackage {
  pname = "torch-cluster";
  version = "1.6.0";
  src = fetchurl {
    url =
      "https://data.pyg.org/whl/torch-1.11.0%2Bcu115/torch_cluster-1.6.0-cp39-cp39-linux_x86_64.whl";
    sha256 = "sha256-CwtoC4XT4rTmSAIbngpwd+uPAgEP2P3cYu9cT3jcqBU=";
    # url =
    #   "https://github.com/rusty1s/pytorch_cluster/archive/refs/tags/1.5.9.tar.gz";
    # #"https://files.pythonhosted.org/packages/4b/27/2f38017ae386ba27c13efe6a87eca7c3c58766c3117c86e0fa2c3f7562a9/torch_cluster-1.5.9.tar.gz";
    # sha256 = "sha256-GbRnGlGekdM0WlmxASrwBHN74+fCFFp9wcyuUp+a51M=";
  };
  format = "wheel";
  doCheck = false;
  enableParallelBuilding = true;
  buildInputs = [ ];
  checkInputs = [ ];
  nativeBuildInputs = [ which ];
  propagatedBuildInputs = [ pytest-runner ];
}
