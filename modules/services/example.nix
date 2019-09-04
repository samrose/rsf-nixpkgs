{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.example;
in

{
  options.services.example = {
    enable = mkEnableOption "Example";

    package = mkOption {
      default = pkgs.example;
      type = types.package;
    };
  };

  config = mkIf cfg.enable {
    systemd.services.example = {
      wantedBy = [ "multi-user.target" ];

      serviceConfig.ExecStart = "${cfg.package}/bin/example";
    };
  };
}
