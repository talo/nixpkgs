{ mkDerivation, fetchurl, makeWrapper, lib, php }:
let
  pname = "psalm";
  version = "4.29.0";
in
mkDerivation {
  inherit pname version;

  src = fetchurl {
    url = "https://github.com/vimeo/psalm/releases/download/${version}/psalm.phar";
    sha256 = "q+OjEPNAPwSjtnbfBynbbJy3WDITr01ci8O74BMO0Og=";
  };

  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    install -D $src $out/libexec/psalm/psalm.phar
    makeWrapper ${php}/bin/php $out/bin/psalm \
      --add-flags "$out/libexec/psalm/psalm.phar"
    runHook postInstall
  '';

  meta = with lib; {
    description = "A static analysis tool for finding errors in PHP applications";
    license = licenses.mit;
    homepage = "https://github.com/vimeo/psalm";
    maintainers = teams.php.members;
  };
}
