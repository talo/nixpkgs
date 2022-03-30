{ lib, fetchurl, buildPythonPackage, rustPlatform, fetchFromGitHub
, typing-extensions, numpy }:

buildPythonPackage rec {
  pname = "polars";
  version = "0.13.16";

  format = "wheel";
  src = fetchurl {
    url =
      "https://files.pythonhosted.org/packages/56/2b/343754d3240bce3e31cc2ff427d61cd5aaa60ed5ddfa3baa0015a0a8f8e0/polars-0.13.15-cp37-abi3-manylinux_2_12_x86_64.manylinux2010_x86_64.whl";
    sha256 = "sha256-IwExYAxn3dkexMoHUjUO3JgWgYbdi1j+q1w87j0Dmd8=";
  };
  buildInputs = [ typing-extensions numpy ];

  # src = fetchFromGitHub {
  #   owner = "pola-rs";
  #   repo = "polars";
  #   rev = "py-polars-v${version}";
  #   sha256 = "sha256-X5RQG73UOOVNYPeVNMMOLXmIxvuaIhn2WcgLG+iJKqU=";
  # };

  # cargoDeps = rustPlatform.fetchCargoTarball {
  #   #inherit src;
  #   name = "${pname}-0.20.0";
  #   hash = "sha256-/kR0lTbpG0mji7jJcjx+TiJrWN6FyBkhBJrsvYnRFnc=";
  # };

  # format = "pyproject";
  # sourceRoot = "py-polars";

  # nativeBuildInputs = with rustPlatform; [ cargoSetupHook maturinBuildHook ];
}
