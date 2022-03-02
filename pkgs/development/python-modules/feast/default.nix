{ lib, python3Packages }:

python3Packages.buildPythonPackage rec {
  pname = "feast";
  version = "0.18.1";
  format = "wheel";

  src = python3Packages.fetchPypi {
    inherit pname version;
    #"https://files.pythonhosted.org/packages/bd/42/75b8a517f36b2c98667332e43479c3d639fe656e2996f8bfac456869e36a/feast-0.18.1-py3-none-any.whl"
    format = "wheel";
    python = "py3";
    dist = "py3";

    sha256 = "46cPejyLUlB+3/D23rUjr+xP8GtsAFuhsbKw3/ZXMIM=";
  };

  pythonPath = with python3Packages; [
    tenacity
    fastapi
    pandas
    pyarrow
    click
    colorama
    dill
    fastavro
    google-api-core
    googleapis-common-protos
    grpcio
    grpcio-reflection
    Jinja2
    jsonschema
    mmh3
    pandas
    pandavro
    protobuf
    proto-plus
    pyarrow
    pydantic
    pyyaml
    tabulate
    tenacity
    toml
    tqdm
    fastapi
    uvicorn
    proto-plus
    tensorflow-metadata
    dask
  ];

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
