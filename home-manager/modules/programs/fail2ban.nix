{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    fail2ban
  ];

  home.file.".config/fail2ban/jail.local" = {
    text = ''
      [DEFAULT]
      bantime = 1h
      findtime = 10m
      maxretry = 5

      [sshd]
      enabled = true
    '';

  };

  systemd.user.services.fail2ban = with pkgs; {
    Unit = {
      Description = "Fail2ban service";
      After = "network.target";
    };
    Service = {
      ExecStart = "${fail2ban}/bin/fail2ban-client -x start";
      ExecStop = "${fail2ban}/bin/fail2ban-client stop";
      Type = "forking";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
