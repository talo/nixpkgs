{
  stdenv,
  jre,
  makeWrapper,
  fetchurl,
}:
stdenv.mkDerivation {
  pname = "p2rank";
  version = "2.4";
  src = fetchurl {
    url = "https://github.com/rdk/p2rank/releases/download/2.4/p2rank_2.4.tar.gz";
    sha256 = "sha256-jxcv60qXO64QA97KF9hG3U5k4FJUzA7D2TSKIaYtCP4=";
  };

  nativeBuildInputs = [makeWrapper];
  buildInputs = [jre];
  buildPhase = ''
    echo done
  '';
  installPhase = ''
            mkdir -p $out/bin
            mkdir -p $out/lib
            cp -r ./bin/* $out/lib/
            cp -r ./config $out
            cp -r ./models $out
            makeWrapper ${jre}/bin/java $out/bin/p2rank \
            --add-flags "\
    --add-opens=java.base/sun.nio.fs=ALL-UNNAMED --add-opens=java.base/java.io=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.lang.annotation=ALL-UNNAMED --add-opens=java.base/java.lang.invoke=ALL-UNNAMED --add-opens=java.base/java.lang.module=ALL-UNNAMED --add-opens=java.base/java.lang.ref=ALL-UNNAMED --add-opens=java.base/java.lang.reflect=ALL-UNNAMED --add-opens=java.base/java.math=ALL-UNNAMED --add-opens=java.base/java.net=ALL-UNNAMED --add-opens=java.base/java.net.spi=ALL-UNNAMED --add-opens=java.base/java.nio=ALL-UNNAMED --add-opens=java.base/java.nio.channels=ALL-UNNAMED --add-opens=java.base/java.nio.channels.spi=ALL-UNNAMED --add-opens=java.base/java.nio.charset=ALL-UNNAMED --add-opens=java.base/java.nio.charset.spi=ALL-UNNAMED --add-opens=java.base/java.nio.file=ALL-UNNAMED --add-opens=java.base/java.nio.file.attribute=ALL-UNNAMED --add-opens=java.base/java.nio.file.spi=ALL-UNNAMED --add-opens=java.base/java.security=ALL-UNNAMED --add-opens=java.base/java.security.acl=ALL-UNNAMED --add-opens=java.base/java.security.cert=ALL-UNNAMED --add-opens=java.base/java.security.interfaces=ALL-UNNAMED --add-opens=java.base/java.security.spec=ALL-UNNAMED --add-opens=java.base/java.text=ALL-UNNAMED --add-opens=java.base/java.text.spi=ALL-UNNAMED --add-opens=java.base/java.time=ALL-UNNAMED --add-opens=java.base/java.time.chrono=ALL-UNNAMED --add-opens=java.base/java.time.format=ALL-UNNAMED --add-opens=java.base/java.time.temporal=ALL-UNNAMED --add-opens=java.base/java.time.zone=ALL-UNNAMED --add-opens=java.base/java.util=ALL-UNNAMED --add-opens=java.base/java.util.concurrent=ALL-UNNAMED --add-opens=java.base/java.util.concurrent.atomic=ALL-UNNAMED --add-opens=java.base/java.util.concurrent.locks=ALL-UNNAMED --add-opens=java.base/java.util.function=ALL-UNNAMED --add-opens=java.base/java.util.jar=ALL-UNNAMED --add-opens=java.base/java.util.regex=ALL-UNNAMED --add-opens=java.base/java.util.spi=ALL-UNNAMED --add-opens=java.base/java.util.stream=ALL-UNNAMED --add-opens=java.base/java.util.zip=ALL-UNNAMED --add-opens=java.datatransfer/java.awt.datatransfer=ALL-UNNAMED --add-opens=java.desktop/java.applet=ALL-UNNAMED --add-opens=java.desktop/java.awt=ALL-UNNAMED --add-opens=java.desktop/java.awt.color=ALL-UNNAMED --add-opens=java.desktop/java.awt.desktop=ALL-UNNAMED --add-opens=java.desktop/java.awt.dnd=ALL-UNNAMED --add-opens=java.desktop/java.awt.dnd.peer=ALL-UNNAMED --add-opens=java.desktop/java.awt.event=ALL-UNNAMED --add-opens=java.desktop/java.awt.font=ALL-UNNAMED --add-opens=java.desktop/java.awt.geom=ALL-UNNAMED --add-opens=java.desktop/java.awt.im=ALL-UNNAMED --add-opens=java.desktop/java.awt.im.spi=ALL-UNNAMED --add-opens=java.desktop/java.awt.image=ALL-UNNAMED --add-opens=java.desktop/java.awt.image.renderable=ALL-UNNAMED --add-opens=java.desktop/java.awt.peer=ALL-UNNAMED --add-opens=java.desktop/java.awt.print=ALL-UNNAMED --add-opens=java.desktop/java.beans=ALL-UNNAMED --add-opens=java.desktop/java.beans.beancontext=ALL-UNNAMED --add-opens=java.instrument/java.lang.instrument=ALL-UNNAMED --add-opens=java.logging/java.util.logging=ALL-UNNAMED --add-opens=java.management/java.lang.management=ALL-UNNAMED --add-opens=java.prefs/java.util.prefs=ALL-UNNAMED --add-opens=java.rmi/java.rmi=ALL-UNNAMED --add-opens=java.rmi/java.rmi.activation=ALL-UNNAMED --add-opens=java.rmi/java.rmi.dgc=ALL-UNNAMED --add-opens=java.rmi/java.rmi.registry=ALL-UNNAMED --add-opens=java.rmi/java.rmi.server=ALL-UNNAMED --add-opens=java.sql/java.sql=ALL-UNNAMED  --add-opens=java.desktop/javax.swing=ALL-UNNAMED --add-opens=java.desktop/javax.swing.border=ALL-UNNAMED --add-opens=java.desktop/javax.swing.text=ALL-UNNAMED --add-opens=java.desktop/javax.swing.text.html=ALL-UNNAMED --add-opens=java.desktop/sun.awt=ALL-UNNAMED --add-opens=java.desktop/sun.java2d=ALL-UNNAMED --add-opens=java.desktop/sun.font=ALL-UNNAMED \
    -cp $out/lib/p2rank.jar:$out/lib/lib/* cz.siret.prank.program.Main"
  '';
}
