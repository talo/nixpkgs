{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell {
  buildInputs = [
    (import ./default.nix {
      stdenv = pkgs.stdenv;
      lib = pkgs.lib;
      gcc = pkgs.gcc;
      libcxx = pkgs.libcxx;
      pkg-config = pkgs.pkg-config;
      fetchFromGitHub = pkgs.fetchFromGitHub;
      cudatoolkit = pkgs.cudatoolkit_11_4;
    })
  ];
}
