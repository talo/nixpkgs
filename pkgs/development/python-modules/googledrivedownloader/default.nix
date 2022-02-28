{ buildPythonPackage, fetchurl, }:
buildPythonPackage {
  pname = "googledrivedownloader";
  version = "0.4";
  src = fetchurl {
    url =
      "https://files.pythonhosted.org/packages/3a/5c/485e8724383b482cc6c739f3359991b8a93fb9316637af0ac954729545c9/googledrivedownloader-0.4-py2.py3-none-any.whl";
    sha256 = "0wrvdbym1g4al2iikq4wxbbvdw7n1b5v0xgk6vxyd38399n91vr6";
  };
  format = "wheel";
  doCheck = false;
  buildInputs = [ ];
  checkInputs = [ ];
  nativeBuildInputs = [ ];
  propagatedBuildInputs = [ ];
}
