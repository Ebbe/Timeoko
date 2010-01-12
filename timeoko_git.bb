DESCRIPTION = "An eggtimer for the Openmoko phones"
AUTHOR = "Esben Damgaard"
LICENSE = "GPLv3"
DEPENDS = "vala-native glib-2.0 dbus dbus-glib libgee"

SRCREV = "${AUTOREV}"
PV = "0.0.2+gitr${SRCREV}"

SRC_URI = "git://github.com/Ebbe/Timeoko.git;protocol=git;branch=master"
S = "${WORKDIR}/git/"

do_compile() {
  cd ${S}
  ./compile
}

do_install() {
  install -d ${D}/usr/share/sounds/
  install -d ${D}/usr/share/pixmaps/
  install -d ${D}/usr/share/applications/
  install -d ${D}/usr/bin
  
  install -m 0755 ${S}/bin/timeoko ${D}/usr/bin
  install -m 0755 ${S}/data/timeoko.desktop ${D}/usr/share/applications/
  install -m 0755 ${S}/data/timeoko.png ${D}/usr/share/pixmaps/
  install -m 0755 ${S}/data/timeoko_ring.wav ${D}/usr/share/sounds/
}

