{ inputs, pkgs, config, lib, ... }:
with lib;

let
  cfg = config.modules.profiles.core;
in
{
  options.modules.profiles.server = {
    enable = mkOption {
      description = "Enable server options";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf (cfg.enable) {
    imports = [ ./containers ];

    modules = {
      containers = {
        bazarr.enable = true;
        deluge.enable = false;
        jackett.enable = true;
        plex.enable = true;
        radarr.enable = true;
        sonarr.enable = true;
        transmission.enable = true;
      };
      services = {
        adGuardHome.enable = true;
        miniflux.enable = true;
      };
    };
  
    services.nfs.server = {
      enable = true;
      exports = ''
        /media  100.91.89.2(rw,insecure,no_subtree_check)
      '';
    };
  
    networking.nat = {
      enable = true;
      externalInterface = "wlan0";
    };
  
    ## FileSystem ##
    fileSystems."/nix/persist/media" = {
      device = "/dev/disk/by-label/exthdd";
      fsType = "ntfs";
      options = [ "rw" "uid=1000" "gid=100" ];
    };
  
    environment.persistence."/nix/persist" = {
      hideMounts = true;
      directories = [
        "/media"
      ];
    };
  };

}
