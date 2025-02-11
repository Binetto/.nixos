{ config, flake, lib, pkgs, ... }:

{

  imports = [ ./modules ];

  modules.server.containers = {
    adGuardHome.enable = true;
    nextcloud.enable = true;
  };

  device.type = "server";
  modules.system = {
    home.enable = true;
  };

}
