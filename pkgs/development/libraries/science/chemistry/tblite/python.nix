{ buildPythonPackage
, meson
, ninja
, pkg-config
, tblite
, numpy
, simple-dftd3
, cffi
, gfortran
, blas
, lapack
, mctc-lib
, mstore
, toml-f
, multicharge
, dftd4
}:

buildPythonPackage {
  inherit (tblite) pname version src meta;

  nativeBuildInputs = [
    tblite
    meson
    ninja
    pkg-config
    gfortran
    mctc-lib
  ];

  buildInputs = [
    tblite
    simple-dftd3
    blas
    lapack
    mctc-lib
    mstore
    toml-f
    multicharge
    dftd4
  ];

  propagatedBuildInputs = [ tblite simple-dftd3 cffi numpy ];
  patches = [ ./0001-fix-multicharge-dep-needed-for-static-compilation.patch ];

  format = "other";

  configurePhase = ''
    runHook preConfigure

    meson setup build -Dpython=true --prefix=$out
    cd build

    runHook postConfigure
  '';
}
