{
  buildPythonPackage,
  numpy,
  joblib,
  numpydoc,
  pandas,
  rdkit,
  scikit-learn,
  scipy,
  six,
}:
buildPythonPackage {
  src = fetchTarball {
    url = "https://github.com/oddt/oddt/tarball/bfbf9ea99768b556684dc99c6ac87a9f16b16f80";
    sha256 = "sha256:1n0zkj2m7iqsz3ly0cvgx617pfrxz0qilslldzprki6pa129bzaw";
  };
  pname = "oddt";
  version = "0.7";
  doCheck = false;
  buildInputs = [
    numpy
    joblib
    numpydoc
    pandas
    rdkit
    scikit-learn
    scipy
    six
  ];
  # requirements = ''
  #   flit-core
  #   typing-extensions >= 4.1.0
  #   joblib>=0.10
  #   numpy>=1.12
  #   numpydoc
  #   pandas>=0.19.2
  #   rdkit-pypi
  #   scikit-learn>=0.18
  #   scipy>=0.19
  #   six
  # '';
}
