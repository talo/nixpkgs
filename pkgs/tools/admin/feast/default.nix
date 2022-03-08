{ lib, python3, writeText }:

let py = python3.pkgs;
in py.toPythonApplication (py.feast.overridePythonAttrs (old: rec {
  pname = "feast";

  #propagatedBuildInputs = old.propagatedBuildInputs ++ [ ];
}))
