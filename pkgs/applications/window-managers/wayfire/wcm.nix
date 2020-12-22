{ stdenv, lib, fetchFromGitHub, meson, ninja, pkg-config, wayland, wrapGAppsHook
, gnome3, libevdev, libxml2, wayfire, wayland-protocols, wf-config, wf-shell
}:

stdenv.mkDerivation rec {
  pname = "wcm";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "WayfireWM";
    repo = "wcm";
    rev = "v${version}";
    sha256 = "0xdjrmpdwag2d7bhqa2iall0rdsqpzfgix279lp2zy1ldw9gzg1n";
  };

  nativeBuildInputs = [ meson ninja pkg-config wayland wrapGAppsHook ];
  buildInputs = [
    gnome3.gtk libevdev libxml2 wayfire wayland
    wayland-protocols wf-config wf-shell
  ];

  meta = with lib; {
    homepage = "https://github.com/WayfireWM/wcm";
    description = "Wayfire Config Manager";
    license = licenses.mit;
    maintainers = with maintainers; [ qyliss wucke13 ];
    platforms = platforms.unix;
  };
}
