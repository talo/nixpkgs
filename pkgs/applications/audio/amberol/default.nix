{ lib
, stdenv
, fetchFromGitLab
, rustPlatform
, desktop-file-utils
, appstream-glib
, meson
, ninja
, pkg-config
, reuse
, m4
, wrapGAppsHook4
, glib
, gtk4
, gst_all_1
, libadwaita
, dbus
}:

stdenv.mkDerivation rec {
  pname = "amberol";
  version = "0.6.3";

  src = fetchFromGitLab {
    domain = "gitlab.gnome.org";
    owner = "World";
    repo = pname;
    rev = version;
    hash = "sha256-KV3nYJbLaQxpMpC7aCzfpNMe9bYpZKrdoOtYA++eC74=";
  };

  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit src;
    name = "${pname}-${version}";
    hash = "sha256-UjHL/5iVht2jPnOiYjoIKWJdvwQQkNuKfF8rpi48j3c=";
  };

  postPatch = ''
    patchShebangs build-aux
  '';

  nativeBuildInputs = [
    appstream-glib
    desktop-file-utils
    meson
    ninja
    pkg-config
    reuse
    m4
    wrapGAppsHook4
  ] ++ (with rustPlatform; [
    cargoSetupHook
    rust.cargo
    rust.rustc
  ]);

  buildInputs = [
    glib
    gtk4
    libadwaita
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    dbus
  ];

  meta = with lib; {
    homepage = "https://gitlab.gnome.org/ebassi/amberol";
    description = "A small and simple sound and music player";
    maintainers = with maintainers; [ linsui ];
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
