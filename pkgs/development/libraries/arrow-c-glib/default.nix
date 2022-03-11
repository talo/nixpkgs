{ config, stdenv, fetchurl, lib, pkgs, gobject-introspection, meson, ninja
, gtk-doc, arrow-cpp, cmake, pkgconfig }:

stdenv.mkDerivation rec {
  pname = "arrow-c-glib";
  version = "7.0.0";

  src = fetchurl {
    url =
      "mirror://apache/arrow/arrow-${version}/apache-arrow-${version}.tar.gz";
    hash = "sha256-6PSbFJoV7O9OQPz6sbh8ETxrHuGGAFwWnlzfldMamd4=";
  };
  sourceRoot = "apache-arrow-${version}/c_glib";

  nativeBuildInputs =
    [ meson ninja gobject-introspection gtk-doc arrow-cpp pkgconfig cmake ];
  buildInputs = [ arrow-cpp gobject-introspection gtk-doc pkgconfig cmake ];
}
