{ lib, stdenv, buildPythonPackage, grpc, six, protobuf, enum34 ? null
, pkg-config, fetchPypi, c-ares, openssl, zlib }:

buildPythonPackage rec {
  pname = "grpcio-reflection";
  version = "1.44.0";
  src = fetchPypi {
    inherit pname version;
    #"https://files.pythonhosted.org/packages/bd/42/75b8a517f36b2c98667332e43479c3d639fe656e2996f8bfac456869e36a/feast-0.18.1-py3-none-any.whl"
    format = "wheel";
    python = "py3";
    dist = "py3";

    sha256 = "46cPejyLUlB+3/D23rUjr+xP8GtsAFuhsbKw3/ZXMIMa";
  };

}
