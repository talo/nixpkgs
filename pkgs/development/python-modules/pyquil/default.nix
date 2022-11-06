{ lib
, buildPythonPackage
, fetchFromGitHub
, importlib-metadata
, ipython
, lark
, networkx
, numpy
, poetry-core
, pytest-asyncio
, pytest-freezegun
, pytest-httpx
, pytest-mock
, pytestCheckHook
, pythonOlder
, qcs-api-client
, respx
, retry
, rpcq
, scipy
, types-python-dateutil
, types-retry
}:

buildPythonPackage rec {
  pname = "pyquil";
  version = "3.3.2";
  format = "pyproject";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "rigetti";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-Ur7dRxmnaAWXHk7c6NC3lBw59RRgh9vwAHFW00fViD4=";
  };

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    lark
    networkx
    numpy
    qcs-api-client
    retry
    rpcq
    scipy
    types-python-dateutil
    types-retry
  ] ++ lib.optionals (pythonOlder "3.8") [
    importlib-metadata
  ];

  checkInputs = [
    pytest-asyncio
    pytest-freezegun
    pytest-httpx
    pytest-mock
    pytestCheckHook
    respx
    ipython
  ];

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace 'lark = "^0.11.1"' 'lark = "*"' \
      --replace 'qcs-api-client = ">=0.8.1,<0.21.0"' 'qcs-api-client = "*"'
  '';

  disabledTestPaths = [
    # Tests require network access
    "test/e2e/"
    "test/unit/test_api.py"
    "test/unit/test_engagement_manager.py"
    "test/unit/test_operator_estimation.py"
    "test/unit/test_wavefunction_simulator.py"
    "test/unit/test_compatibility_v2_operator_estimation.py"
    "test/unit/test_compatibility_v2_quantum_computer.py"
    "test/unit/test_compatibility_v2_qvm.py"
    "test/unit/test_quantum_computer.py"
    "test/unit/test_qvm.py"
    "test/unit/test_reference_wavefunction.py"
    # Out-dated
    "test/unit/test_qpu_client.py"
  ];

  disabledTests = [
    "test_compile_with_quilt_calibrations"
    "test_sets_timeout_on_requests"
    # sensitive to lark parser output
    "test_memory_commands"
    "test_classical"
  ];

  pythonImportsCheck = [
    "pyquil"
  ];

  meta = with lib; {
    description = "Python library for creating Quantum Instruction Language (Quil) programs";
    homepage = "https://github.com/rigetti/pyquil";
    license = licenses.asl20;
    maintainers = with maintainers; [ fab ];
  };
}
