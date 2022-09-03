{
  buildPythonPackage,
  cmake,
  fetchFromGitHub,
  opencl-headers,
  doxygen,
  swig,
  which,
  cython,
  numpy,
  setuptools,
}:
buildPythonPackage {
  pname = "openmm";
  version = "93016d5c549419d3ebc41a1b68aa2004059956cb";
  src = fetchFromGitHub {
    owner = "tristanic";
    repo = "openmm";
    rev = "93016d5c549419d3ebc41a1b68aa2004059956cb";
    hash = "sha256-fR2KK85q5tcWpMQA2/COXD4GTl03+j8afWpki3YpL/Q=";
  };
  buildPhase = ''
    cmake . \
        -DCMAKE_INSTALL_PREFIX=python/openmm \
        -DCMAKE_PREFIX_PATH=python/openmm \
        -DOPENMM_BUILD_CUDA_TESTS=OFF \
        -DOPENMM_BUILD_OPENCL_TESTS=OFF \
        -DOPENMM_BUILD_CPU_LIB=ON \
        -DOPENMM_BUILD_PYTHON_WRAPPERS=ON \
        -DOPENMM_BUILD_REFERENCE_TESTS=OFF \
        -DOPENMM_BUILD_SERIALIZATION_TESTS=OFF \
        -DOPENMM_BUILD_C_AND_FORTRAN_WRAPPERS=OFF \
        -DOPENMM_BUILD_EXAMPLES=OFF \
        -DOPENMM_BUILD_UNVERSIONED=ON

    export OPENMM_MAKE_WHEEL=1
    make -j $(nproc)
    make install

    cd python
    export OPENMM_INCLUDE_PATH=openmm/include
    export OPENMM_LIB_PATH=openmm/lib
    python setup.py bdist_wheel
  '';
  nativeBuildInputs = [cmake];
  doCheck = false;

  buildInputs = [
    cmake
    opencl-headers
    doxygen
    swig
    which
    cython
    numpy
    setuptools
  ];
}
