{ pkgs ? import ./. {} }:

with pkgs;

let
  root = toString ./.;
in

mkShell {
  shellHook = ''
    nixos-shell() {
      $(nix-build -A example-nixpkgs.qemu --no-out-link)/bin/run-nixos-vm
    }
  '';

  NIX_PATH = builtins.concatStringsSep ":" [
    "example-nixpkgs=${root}"
    "nixpkgs=${root}/nixpkgs"
    "nixpkgs-overlays=${root}/overlays"
  ];
}
