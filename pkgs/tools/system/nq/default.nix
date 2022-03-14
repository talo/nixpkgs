{ stdenv, lib, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "nq";
  version = "0.5";
  src = fetchFromGitHub {
    owner = "chneukirchen";
    repo = "nq";
    rev = "72da652ad6e7682bea6f54fbb27fbbba7d1f9f7d";
    sha256 = "sha256-kXqgrxKucgY7VgNU/L0dtw1yO1ePCvxeLB6706MFnoo=";
  };
  makeFlags = [ "PREFIX=$(out)" ];
  postPatch = ''
    sed -i tq \
      -e 's|\bnq\b|'$out'/bin/nq|g' \
      -e 's|\bfq\b|'$out'/bin/fq|g'
  '';
  meta = with lib; {
    description = "Unix command line queue utility";
    homepage = "https://github.com/chneukirchen/nq";
    license = licenses.publicDomain;
    platforms = platforms.all;
    maintainers = with maintainers; [ cstrahan ];
  };
}
