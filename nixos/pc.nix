{ pkgs, config, flake, lib, ... }:
let
  inherit (config.meta) username;
in
  with config.users.users.${username};
{

  imports = [
    #./libvirt
  ];

    # Some misc packages
  environment.systemPackages = with pkgs; [ ];
    # Get rid of defaults packages
  environment.defaultPackages = [ ];

  #TODO: users.users.${username} = { extraGroups = [ ]; };

  services = {
      # Enable irqbalance service
    irqbalance.enable = true;
      # Enable printing
    printing = { enable = true; drivers = with pkgs; [ ]; };
    dbus.implementation = "broker";
#    udisks2.enable = true;
  };

  hardware = {
    opengl.enable = true; # Enable opengl
      # Enable Font/DPI configuration optimized for HiDPI displays
    video.hidpi.enable = true;
  };

    # Needed by home-manager's impermanence
  programs.fuse.userAllowOther = true;

  # TODO: transmission services

    # Don't install documentation I don't use
  documentation = {
    enable = true; # documentation of packages
    nixos.enable = true; # nixos documentation
    man.enable = true; # manual pages and the man command
    info.enable = false; # info pages and the info command
    doc.enable = false; # documentation distributed in packages' /share/doc
  };

    # Sops-nix password encryption
  sops.defaultSopsFile = ../../../secrets/common.yaml;
  sops.age.sshKeyPaths = [ "/home/binette/.ssh/id_ed25519" ];
  
  environment.etc = {
    "machine-id".source = "/nix/persist/etc/machine-id";
    "ssh/ssh_host_rsa_key".source = "/nix/persist/etc/ssh/ssh_host_rsa_key";
    "ssh/ssh_host_rsa_key.pub".source = "/nix/persist/etc/ssh/ssh_host_rsa_key.pub";
    "ssh/ssh_host_ed25519_key".source = "/nix/persist/etc/ssh/ssh_host_ed25519_key";
    "ssh/ssh_host_ed25519_key.pub".source = "/nix/persist/etc/ssh/ssh_host_ed25519_key.pub";
  };

    # TODO:
  #systemd.tmpfiles.rules = [
    #"d ${archive}/Downloads 0775 ${username} ${group}"
    #"d ${archive}/Music 0775 ${username} ${group}"
    #"d ${archive}/Photos 0775 ${username} ${group}"
    #"d ${archive}/Videos 0775 ${username} ${group}"
  #];

}

