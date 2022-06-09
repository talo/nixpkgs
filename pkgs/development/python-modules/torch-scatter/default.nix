{ buildPythonPackage, fetchurl, torch-spline-conv, which, pytest-runner, ninja
}:

buildPythonPackage {
  pname = "torch-scatter";
  version = "2.0.9";
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
  nativeBuildInputs = [ which ];
  checkInputs = [ ];
  propagatedBuildInputs = [ pytest-runner ];
}
