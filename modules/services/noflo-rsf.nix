{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.noflo-rsf;
in

{
  options.services.noflo-rsf = {
    enable = mkEnableOption "Example";

    package = mkOption {
      default = pkgs.noflo-rsf;
      type = types.package;
    };
  };

  config = mkIf cfg.enable {
    systemd.services.noflo-rsf = {
      wantedBy = [ "multi-user.target" ];

      serviceConfig.ExecStart = "${cfg.package}/bin";
    };
  };
}
