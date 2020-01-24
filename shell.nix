{ pkgs ? import ./. {} }:

with pkgs;

let
  root = toString ./.;
in

mkShell {
  shellHook = ''
    nixos-shell() {
      $(nix-build -A rsf-nixpkgs.qemu -I nixos-config=profiles/$1 --no-out-link)/bin/run-nixos-vm
    }
  '';

  NIX_PATH = builtins.concatStringsSep ":" [
    "rsf-nixpkgs=${root}"
    "nixpkgs=${root}/nixpkgs"
    "nixpkgs-overlays=${root}/overlays"
  ];
}
