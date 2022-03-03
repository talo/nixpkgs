{ lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  pname = "distribution";
  version = "2.8.0";
  rev = "v${version}";

  goPackagePath = "github.com/docker/distribution";

  src = fetchFromGitHub {
    owner = "docker";
    repo = "distribution";
    inherit rev;
    sha256 = "oSGrMlXFwQ+lnGK5aCY31zO/c2okwGbQA6M8KXuNAXQ=";
  };

  tags = [ "include_gcs" ];

  meta = with lib; {
    description =
      "The Docker toolset to pack, ship, store, and deliver content";
    license = licenses.asl20;
    maintainers = [ maintainers.globin ];
    platforms = platforms.unix;
  };
}
