{ config, pkgs, ... }:

{
  imports = [ ../modules ];
  environment.systemPackages = [ pkgs.git pkgs.curl ];
  services.mingetty.autologinUser = "root";
  services.noflo-rsf.enable = true;
}
