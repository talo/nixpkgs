{ lib
, stdenv
, buildPythonPackage
, fetchPypi
, pythonOlder
, setuptools-scm
, importlib-metadata
, dbus-python
, jaraco_classes
, jeepney
, secretstorage
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "keyring";
  version = "23.9.3";
  format = "pyproject";
  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-abAd2DxC9ZAlD+eh9QP8IpsU3oOFcxSxkzo92/WVxKU=";
  };

  nativeBuildInputs = [
    setuptools-scm
  ];

  propagatedBuildInputs = [
    jaraco_classes
  ] ++ lib.optionals stdenv.isLinux [
    jeepney
    secretstorage
  ] ++ lib.optionals (pythonOlder "3.10") [
    importlib-metadata
  ];


  pythonImportsCheck = [
    "keyring"
    "keyring.backend"
  ];

  checkInputs = [
    pytestCheckHook
  ];

  disabledTests = [
    # E       ValueError: too many values to unpack (expected 1)
    "test_entry_point"
  ];

  disabledTestPaths = [
    "tests/backends/test_macOS.py"
  ];

  meta = with lib; {
    description = "Store and access your passwords safely";
    homepage    = "https://github.com/jaraco/keyring";
    license     = licenses.mit;
    maintainers = with maintainers; [ lovek323 dotlambda ];
    platforms   = platforms.unix;
  };
}
