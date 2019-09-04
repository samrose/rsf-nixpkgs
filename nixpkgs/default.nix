let
  nixpkgs = import ../vendor/nixpkgs.nix;
  patches = [];
in

with import nixpkgs { overlays = []; };

import (stdenvNoCC.mkDerivation {
  name = "nixpkgs";
  src = nixpkgs;

  phases = [ "unpackPhase" "patchPhase" "installPhase" ];

  inherit patches;

  installPhase = ''
    mv $PWD $out
  '';
})
