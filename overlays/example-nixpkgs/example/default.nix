{ stdenv, meson, ninja }:

stdenv.mkDerivation {
  name = "example";
  src = ./.;

  nativeBuildInputs = [ meson ninja ];
}
