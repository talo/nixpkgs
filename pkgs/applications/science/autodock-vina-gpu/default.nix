{
  stdenv,
  boost177,
  git,
  cudatoolkit,
  ocl-icd,
  fetchurl,
  linuxPackages,
  addOpenGLRunpath,
}:
stdenv.mkDerivation rec {
  pname = "Vina-GPU";
  version = "dev";
  src = fetchurl {
    url = "https://github.com/DeltaGroupNJUPT/Vina-GPU/archive/refs/heads/main.tar.gz";
    sha256 = "sha256-0J3NjVxKrmaoNC6iP0tL1JXQ/iZOJPHJr8Nenog91pQ=";
  };
  nativeBuildInputs = [
    ocl-icd
    cudatoolkit
  ];
  buildInputs = [
    boost177
    git
    ocl-icd
    cudatoolkit
  ];
  buildPhase = ''
    tar -xf  ${boost177.src}
    make -j12 OPENCL_LIB_PATH=${ocl-icd} BOOST_LIB_PATH=./boost_1_77_0
  '';
  installPhase = ''
    mkdir -p $out/bin
    ls >> $out/ls.txt
    cp ./Vina-GPU $out/bin/
  '';
}
