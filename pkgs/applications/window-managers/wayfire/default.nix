{ stdenv, lib, fetchFromGitHub, meson, ninja, pkg-config, git
, cairo, libdrm, libexecinfo, libinput, libjpeg, libxkbcommon, wayland
, wayland-protocols, wf-config, wlroots,

findutils, # TODO REMOVE
}:

stdenv.mkDerivation rec {
  pname = "wayfire";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "WayfireWM";
    repo = "wayfire";
    rev = version;
    sha256 = "1glrfzz0dk1xgljk71vl138zpsdc765w29ik9x5dqcnwjj2sq4px";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ meson ninja pkg-config wayland ];
  buildInputs = [
    cairo libdrm libexecinfo libinput libjpeg libxkbcommon wayland
    wayland-protocols wf-config wlroots
  ];

  mesonFlags = [ "--sysconfdir" "/etc" ];

  postInstall = ''
	mkdir -p "$out/share/wayland-sessions/"
    cp -f "$src/wayfire.desktop" "$out/share/wayland-sessions/"
  '';

  meta = with lib; {
    homepage = "https://wayfire.org/";
    description = "3D wayland compositor";
    license = licenses.mit;
    maintainers = with maintainers; [ qyliss wucke13 ];
    platforms = platforms.unix;
  };
}
