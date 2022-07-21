{ buildPythonPackage, fetchurl, which, pytest-runner, ninja, python }:

let
  pyVerNoDot = builtins.replaceStrings [ "." ] [ "" ] python.pythonVersion;
  hashes = {
    py39 = {
    url =
      "https://data.pyg.org/whl/torch-1.11.0%2Bcu115/torch_cluster-1.6.0-cp39-cp39-linux_x86_64.whl";
    sha256 = "sha256-CwtoC4XT4rTmSAIbngpwd+uPAgEP2P3cYu9cT3jcqBU=";
    };

    py310 = {
    url =
      "https://data.pyg.org/whl/torch-1.12.0%2Bcu116/torch_cluster-1.6.0-cp310-cp310-linux_x86_64.whl";
    sha256 = "sha256-CwtoC4XT4rTmSAIbngpwd+uPAgEP2P3cYu9cT3jcqB1=";
    };
  };
in
buildPythonPackage {
  pname = "torch-cluster";
  version = "1.6.0";
  src = fetchurl hashes."py${pyVerNoDot}";
  format = "wheel";
  doCheck = false;
  enableParallelBuilding = true;
  buildInputs = [ ];
  checkInputs = [ ];
  nativeBuildInputs = [ which ];
  propagatedBuildInputs = [ pytest-runner ];
}
