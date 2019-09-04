{ pkgs ? import ./. {} }:

with pkgs;

let
  root = toString ./.;
in

mkShell {
  NIX_PATH = builtins.concatStringsSep ":" [
    "example-nixpkgs=${root}"
    "nixpkgs=${root}/nixpkgs"
    "nixpkgs-overlays=${root}/overlays"
  ];
}
