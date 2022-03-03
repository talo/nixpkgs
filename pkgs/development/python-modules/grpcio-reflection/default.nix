{ lib, stdenv, buildPythonPackage, grpc, grpcio, six, protobuf, enum34 ? null
, pkg-config, fetchPypi, c-ares, openssl, zlib }:

buildPythonPackage rec {
  pname = "grpcio_reflection";
  version = "1.43.0";
  format = "wheel";

  src = fetchPypi {
    inherit pname version format;
    python = "py3";
    dist = "py3";

    sha256 = "X1CJqiMb8yk8ChsrsVC8p974GcsOgM8/2pIbogOkJiw=";
  };

  propagatedBuildInputs = [ six protobuf grpcio ];
}
