{ config, flake, lib, pkgs, system, ... }: 
  {

    imports = [ 
      ../../nixos/default.nix
    ];

  ## Custom modules ##
  modules = {
    bootloader = "grub";
    device = {
      type = "desktop";
      gpu = "nvidia";
      netDevices = [ "enp34s0" ];
    };
  };
  
      # GPU
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware = {
      nvidia = {
        modesetting.enable = true;
          # Enable experimental NVIDIA power management via systemd
        powerManagement.enable = true;
      };
      opengl.extraPackages = with pkgs; [ vaapiVdpau ];
    };
  
    ## Networking ##
    networking = {
      interfaces.wlo1.useDHCP = true;
      interfaces.enp34s0.useDHCP = true;
      interfaces.tailscale0.useDHCP = true;
    };
    
    nix.settings.max-jobs = 16; # ryzen 7 5800x
    hardware.cpu.amd.updateMicrocode = true;
    
    nixpkgs.config.allowUnfree = true;

}
