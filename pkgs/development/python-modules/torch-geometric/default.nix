{ buildPythonPackage, fetchurl, jinja2, pyyaml, googledrivedownloader, networkx
, numpy, pandas, pyparsing, rdflib, requests, scikit-learn, scipy, tqdm, yacs }:

buildPythonPackage {
  pname = "torch-geometric";
  version = "2.0.2";
  src = fetchurl {
    url =
      "https://files.pythonhosted.org/packages/05/52/b0bf572b72fb3fd0b57eabd3c46f25d128579c586dfbe25cc4f9d4163306/torch_geometric-2.0.2.tar.gz";
    sha256 = "0i7d57s4cn7c5gzs7d5fj0a1ykgma8r947xr52nmrihdjazpyplz";
  };
  format = "setuptools";
  doCheck = false;
  buildInputs = [ ];
  checkInputs = [ ];
  nativeBuildInputs = [ yacs googledrivedownloader ];
  propagatedBuildInputs = [
    jinja2
    pyyaml
    googledrivedownloader
    networkx
    numpy
    pandas
    pyparsing
    rdflib
    requests
    scikit-learn
    scipy
    tqdm
    yacs
  ];
}
