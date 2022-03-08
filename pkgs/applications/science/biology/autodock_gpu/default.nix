{ stdenv, lib, fetchFromGitHub, cudatoolkit }:

stdenv.mkDerivation rec {
  version = "7b7d5ed516f870611a93b14e14c6b64023eccb14";
  pname = "autodock_gpu";

  src = fetchFromGitHub {
    owner = "ccsb-scripps";
    repo = "AutoDock-GPU";
    rev = "${version}";
    sha256 = "sha256-9Bc5OEbI8NPY+MF73Vvo42IBiWo7JJo0cQ3c2yArTks=";
  };

  buildInputs = [ cudatoolkit ];

  preConfigure = ''
    export GPU_INCLUDE_PATH=${cudatoolkit}/include
    export GPU_LIBRARY_PATH=${cudatoolkit}/lib
  '';

  makeFlags = [ "DEVICE=CUDA" ];
  installPhase = ''
    install -m755 -D ./bin/autodock_gpu_64wi $out/bin/autodock_gpu_64wi
  '';

  meta = with lib; {
    description = " AutoDock for GPUs and other accelerators ";
    homepage = "https://autodock.scripps.edu/";
    license = licenses.gpl3;
    maintainers = [ maintainers.iimog ];
    # at least SSE is *required*
    platforms = platforms.x86_64;
  };
}
