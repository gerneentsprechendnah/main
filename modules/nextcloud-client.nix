{ config, lib, pkgs, ... }:
{
systemd.user.services.nextcloud-client = {
      Unit = {
        Description = "Easyeffects daemon";
        Requires = [ "dbus.service" ];
        After = [ "graphical-session-pre.target" ];
      };

      Install.WantedBy = [ "graphical-session.target" ];

      Service = {
        ExecStart =
          "${pkgs.nextcloud-client}/bin/nextcloud-client";
        ExecStop = "${pkgs.nextcloud-client}/bin/nextcloud-client --quit";
        Restart = "on-failure";
        RestartSec = 5;
      };
    };
    }
