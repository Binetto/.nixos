{ config, pkgs, lib, ... }:

with lib; {
  options.device = {
    type = mkOption {
      type = types.enum [ "desktop" "laptop" "server" "vm" ];
      description = "Type of device";
      default = "desktop";
    };
    gpu = mkOption {
      type = types.enum [ "amd" "nvidia" ];
      description = "Type of graphic cards";
      default = "nvidia";
    };
    storage.enable = mkOption {
      description = "type of storage";
      type = types.enum [ "hdd" "ssd" ];
      default = "ssd";
    };
    netDevices = mkOption {
      type = with types; (listOf str);
      description = "Available net devices";
      example = [ "eno1" "wlp2s0" ];
      default = [ "eth0" ];
    };
  };
}
