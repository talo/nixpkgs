{ lib, python3Packages }:

python3Packages.buildPythonPackage rec {
  pname = "feast";
  version = "0.18.1";

  src = python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "1h0phf3s6ljffxw0bs73k041wildaz01h37iv5mxhami41wrh4qa";
  };

  pythonPath = with python3Packages; [ ];

  doCheck = false;

  pythonImportsCheck = [ "feast" ];

  meta = with lib; {
    maintainers = with maintainers; [ ];
    description =
      "Feast is an open source feature store for machine learning. Feast is the fastest path to productionizing analytic data for model training and online inference.";
    homepage = "https://github.com/feast-dev/feast";
    license = licenses.apsl20;
    platforms = platforms.linux;
  };
}
