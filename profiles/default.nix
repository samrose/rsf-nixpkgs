{ config, pkgs, ... }:

{
  services.mingetty.autologinUser = "root";
}
