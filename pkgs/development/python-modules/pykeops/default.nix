{ buildPythonPackage, fetchFromGitHub, cudaPackages_11_4, linuxPackages }:

let
  cudapaths = with pkgs; [
    cudaPackages_11_4.cudatoolkit.out
    cudaPackages_11_4.cudatoolkit.lib
    linuxPackages.nvidia_x11
  ];
  keopscore = pkgs.python3.pkgs.buildPythonPackage {
    # FIXME: currently fails on numpy even though it's the same version
    pname = "keopscore";
    version = "2.0.0";

    # LD_LIBRARY_PATH =
    #   pkgs.lib.makeLibraryPath [ pkgs.addOpenGLRunpath.driverLink ];
    # LD_LIBRARY_PATH =
    #   "${pkgs.linuxPackages.nvidia_x11}/lib/libcuda.so.1:$LD_LIBRARY_PATH";
    # nativeBuildInputs =
    #   [ pkgs.cudatoolkit_11_4 pkgs.addOpenGLRunpath cudapaths ];
    # buildInputs = [ pkgs.cudatoolkit_11_4 cudapaths ];
    propagatedBuildInputs = with pkgs.python3Packages; [
      numpy
      pybind11
      cudapaths
      pkgs.cudaPackages_11_4.cudatoolkit
      pkgs.addOpenGLRunpath
    ];

    postFixup = ''
      find $out/lib -type f \( -name '*.so' -or -name '*.so.*' \) | while read lib; do
        echo "setting opengl runpath for $lib..."
        addOpenGLRunpath "$lib"
      done
    '';

    # Requires access to libcuda.so.1 which is provided by the driver
    doCheck = false;

    src = fetchFromGitHub {
      owner = "talo";
      repo = "keops";
      rev = "main";
    };
    srcRoot = ./keopscore;

    # Requires access to libcuda.so.1 which is provided by the driver
    #pythonImportsCheck = [ "keopscore" ];
  };
in buildPythonPackage {
  pname = "pykeops";
  version = "2.0.2";
  src = fetchFromGitHub {
    owner = "talo";
    repo = "keops";
    rev = "main";
  };
  propagatedBuildInputs = [
    pkgs.python3Packages.pytorch-bin
    keopscore
    pkgs.python3Packages.setuptools
  ];
  srcRoot = ./pykeops;

  postFixup = ''
    find $out/lib -type f \( -name '*.so' -or -name '*.so.*' \) | while read lib; do
      echo "setting opengl runpath for $lib..."
      addOpenGLRunpath "$lib"
    done
  '';
  # Requires access to libcuda.so.1 which is provided by the driver
  doCheck = false;
}
