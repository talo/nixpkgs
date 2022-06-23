{ lib, stdenv, fetchFromGitHub, cmake, python3, python3Packages, expat, ffmpeg
, gdcm, zlib }:

stdenv.mkDerivation rec {
  pname = "ChimeraX";
  version = "1.4";

  src = fetchFromGitHub {
    owner = "RBVI";
    repo = pname;
    rev = "v{version}";
  };

  propagatedBuildInputs = with python3Packages; [
    appdirs
    colorama
    comtypes
    cython
    distlib
    distro
    filelock
    grako
    html2text
    ihm
    imagecodecs-lite
    ipykernel
    ipython
    jupyter-client
    lxml
    lz4
    matplotlib
    msgpack
    networkx
    openvr
    pillow
    pkginfo
    psutil
    pycollada
    pydicom

    qtconsole
    requests
    scipy
    six
    sortedcontainers
    suds-jurko
    tables
    tifffile
    tinyarray
    python-dateutil
    pyqt5
    pyopengl
  ];

}
