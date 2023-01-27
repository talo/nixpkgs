{ lib
, aiohttp-retry
, buildPythonPackage
, dvc-objects
, fsspec
, fetchFromGitHub
, pythonOlder
, setuptools-scm
}:

buildPythonPackage rec {
  pname = "dvc-http";
  version = "2.30.1";
  format = "setuptools";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "iterative";
    repo = pname;
    rev = "refs/tags/${version}";
    hash = "sha256-6dLzhXrZb6QmQzN9NKZOYzbfylJl90+N3qYnbsxlBgo=";
  };

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  nativeBuildInputs = [
    setuptools-scm
  ];

  propagatedBuildInputs = [
    fsspec
    aiohttp-retry
    dvc-objects
  ];

  # Remove circular dependency on dvc
  postPatch = ''
    substituteInPlace setup.cfg --replace "    dvc" ""
  '';

  # Tests require dvc which creates a circular dependency
  doCheck = false;

  pythonImportsCheck = [
    "dvc_http"
  ];

  meta = with lib; {
    description = "HTTP plugin for dvc";
    homepage = "https://github.com/iterative/dvc-http";
    changelog = "https://github.com/iterative/dvc-http/releases/tag/${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [ melling ];
  };
}
