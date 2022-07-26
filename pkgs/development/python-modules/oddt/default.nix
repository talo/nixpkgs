{
  buildPythonPackage,
  numpy,
  joblib,
  numpydoc,
  pandas,
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
  propagatedBuildInputs = [
    numpy
    joblib
    numpydoc
    pandas
    scikit-learn
    scipy
    six
  ];
}
