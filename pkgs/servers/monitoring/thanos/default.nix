{ lib, buildGoModule, fetchFromGitHub }:
buildGoModule rec {
  pname = "thanos";
  version = "0.25.2";

  src = fetchFromGitHub {
    rev = "v${version}";
    owner = "thanos-io";
    repo = "thanos";
    sha256 = "sha256-CAeI+5aC8kSQaKOk/5WCQiQMOX82hogAQGP2Em3DJAw=";
  };

  vendorSha256 = "sha256-tHtfS4PnO9n3ckUdaG6dQAIE2D2PG6km4Tqofaab/eg=";

  doCheck = false;

  subPackages = "cmd/thanos";

  ldflags = let t = "github.com/prometheus/common/version"; in [
    "-X ${t}.Version=${version}"
    "-X ${t}.Revision=unknown"
    "-X ${t}.Branch=unknown"
    "-X ${t}.BuildUser=nix@nixpkgs"
    "-X ${t}.BuildDate=unknown"
  ];

  meta = with lib; {
    description = "Highly available Prometheus setup with long term storage capabilities";
    homepage = "https://github.com/thanos-io/thanos";
    license = licenses.asl20;
    maintainers = with maintainers; [ basvandijk ];
    platforms = platforms.unix;
  };
}
