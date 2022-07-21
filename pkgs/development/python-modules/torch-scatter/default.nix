{
  buildPythonPackage,
  fetchurl,
  torch-spline-conv,
  which,
  pytest-runner,
  ninja,
  python,
}: let
  pyVerNoDot = builtins.replaceStrings ["."] [""] python.pythonVersion;
  hashes = {
    py39 = {
      url = "https://data.pyg.org/whl/torch-1.11.0%2Bcu115/torch_scatter-2.0.9-cp39-cp39-linux_x86_64.whl";
      sha256 = "sha256-GRAopWeJuOYQ9VUhOWgW9zSDPXvB2LpXzoGw81xQ9MI=";
    };
    py310 = {
      url = "https://data.pyg.org/whl/torch-1.12.0%2Bcu116/torch_scatter-2.0.9-cp310-cp310-linux_x86_64.whl";
      sha256 = "sha256-Iok6hjQ2gzO10WAV1DB9+cHJm5Eqf6L4/XhzlgwwVuA=";
    };
  };
in
  buildPythonPackage {
    pname = "torch-scatter";
    version = "2.0.9";
    format = "wheel";
    src = fetchurl hashes."py${pyVerNoDot}";
    doCheck = false;
    nativeBuildInputs = [which];
    checkInputs = [];
    propagatedBuildInputs = [pytest-runner];
  }
