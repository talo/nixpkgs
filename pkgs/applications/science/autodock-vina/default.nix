{ stdenv, boost, fetchFromGitHub, git, gcc }:

stdenv.mkDerivation rec {
  pname = "autodock-vina";
  version = "develop";
  src = fetchFromGitHub {
    owner = "ccsb-scripps";
    repo = "AutoDock-Vina";
    rev = version;
    sha256 = "sha256-+hzFrAmc7z0KnhgxGQSqegYxbOEF4c04BVMcvPuyWxs=";
  };
  #setSourceRoot = "build/linux/release";
  buildPhase = ''
    export LD_LIBRARY_PATH=${boost}/lib
    cd build/linux/release
    make -j12
  '';

  installPhase = ''
    mkdir -p $out/bin
    ls >> $out/ls.txt
    cp ./vina $out/bin/
    cp ./vina_split $out/bin/
  '';

  prePatch = ''
    substituteInPlace build/linux/release/Makefile \
        --replace '/usr/bin/g++' '${gcc}/bin/g++'


    substituteInPlace build/linux/release/Makefile \
        --replace 'C_PLATFORM=-static -pthread' ""

    substituteInPlace build/linux/release/Makefile \
        --replace 'BOOST_VERSION=' 'BOOST_VERSION=1_77'

    substituteInPlace build/linux/release/Makefile \
        --replace 'BOOST_INCLUDE = $(BASE)/include' 'BOOST_INCLUDE=${boost}/include'
  '';

  buildInputs = [ boost git ];
}
