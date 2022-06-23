{ fetchFromGitHub }:
(import (fetchTarball {
  url =
    "https://github.com/edolstra/flake-compat/archive/b4a34015c698c7793d592d66adbab377907a2be8.tar.gz";
  sha256 = "sha256:1qc703yg0babixi6wshn5wm2kgl5y1drcswgszh4xxzbrwkk9sv7";
}) {

  src = fetchFromGitHub {
    owner = "ryanswrt";
    repo = "keops";
    rev = "main";
    hash = "sha256-yYaBLIXc7Yek1n14N000vkrhfFPX0mv3b9tXOuRHUfo=";
  };

}).defaultNix.outputs.defaultPackage.x86_64-linux

# { buildPythonPackage, fetchFromGitHub, cudaPackages_11_5, linuxPackages, python3
# , python3Packages }:

# let
#   cudapaths = [
#     cudaPackages_11_5.cudatoolkit.out
#     cudaPackages_11_5.cudatoolkit.lib
#     linuxPackages.nvidia_x11
#   ];
#   keopscore = python3.pkgs.buildPythonPackage {
#     # FIXME: currently fails on numpy even though it's the same version
#     pname = "keopscore";
#     version = "2.0.0";

#     # LD_LIBRARY_PATH =
#     #   pkgs.lib.makeLibraryPath [ pkgs.addOpenGLRunpath.driverLink ];
#     # LD_LIBRARY_PATH =
#     #   "${pkgs.linuxPackages.nvidia_x11}/lib/libcuda.so.1:$LD_LIBRARY_PATH";
#     # nativeBuildInputs =
#     #   [ pkgs.cudatoolkit_11_4 pkgs.addOpenGLRunpath cudapaths ];
#     # buildInputs = [ pkgs.cudatoolkit_11_4 cudapaths ];
#     propagatedBuildInputs = with python3Packages; [
#       numpy
#       pybind11
#       cudapaths
#       pkgs.cudaPackages_11_4.cudatoolkit
#       pkgs.addOpenGLRunpath
#     ];
#     preBuild = "ls";
#     postUnpack = "ls";

#     postFixup = ''
#       find $out/lib -type f \( -name '*.so' -or -name '*.so.*' \) | while read lib; do
#         echo "setting opengl runpath for $lib..."
#         addOpenGLRunpath "$lib"
#       done
#     '';

#     # Requires access to libcuda.so.1 which is provided by the driver
#     doCheck = false;

#     src = fetchFromGitHub {
#       owner = "ryanswrt";
#       repo = "keops";
#       rev = "main";
#       hash = "sha256-yYaBLIXc7Yek1n14N000vkrhfFPX0mv3b9tXOuRHUfo=";
#     };
#     #sourceRoot = "./keopscore";

#     # Requires access to libcuda.so.1 which is provided by the driver
#     #pythonImportsCheck = [ "keopscore" ];
#   };
# in buildPythonPackage {
#   pname = "pykeops";
#   version = "2.0.2";
#   src = fetchFromGitHub {
#     owner = "ryanswrt";
#     repo = "keops";
#     rev = "main";
#     hash = "sha256-yYaBLIXc7Yek1n14N000vkrhfFPX0mv3b9tXOuRHUfo=";
#   };
#   propagatedBuildInputs =
#     [ python3Packages.pytorch-bin keopscore python3Packages.setuptools ];
#   sourceRoot = "./pykeops";

#   postFixup = ''
#     find $out/lib -type f \( -name '*.so' -or -name '*.so.*' \) | while read lib; do
#       echo "setting opengl runpath for $lib..."
#       addOpenGLRunpath "$lib"
#     done
#   '';
#   # Requires access to libcuda.so.1 which is provided by the driver
#   doCheck = false;
# }
