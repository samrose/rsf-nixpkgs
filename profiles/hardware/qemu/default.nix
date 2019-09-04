{ config, pkgs, ... }:

let
  nixpkgs = import ../../../vendor/nixpkgs.nix;
in

{
  imports = [
    "${nixpkgs}/nixos/modules/virtualisation/qemu-vm.nix"
  ];

  virtualisation.graphics = false;
}
