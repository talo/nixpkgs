{ lib, stdenv, fetchFromGitHub, cmake }:

stdenv.mkDerivation rec {
  pname = "reduce";
  version = "4.7";
  src = fetchFromGitHub {
    owner = "rlabduke";
    repo = "reduce";
    rev = "v${version}";
    sha256 = "sha256-xFkS/IUcA9k+5NLz6u7Q3C4nY/Wemj6HiCa58Nzri88=";
  };
  buildInputs = [ cmake ];
  installPhase = ''
    mkdir $out
    mkdir $out/lib
    mkdir $out/bin
    cp libpdb/libpdb++.a $out/lib/libpdb++.a
    cp toolclasses/libtoolclasses.a $out/lib/libtoolclasses.a
    cp reduce_src/libreducelib.a $out/lib/libreducelib.a
    cp reduce_src/reduce $out/bin/reduce
  '';
}
