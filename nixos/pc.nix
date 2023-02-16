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


  /* --- Transmission Container --- */
  networking.nat.internalInterfaces = [ "ve-transmission" ];
  networking.firewall.allowedTCPPorts = [ 9091 ];

  containers.transmission = {
    autoStart = true;
    ephemeral = true;
  
      # networking & port forwarding
    privateNetwork = true;
    hostAddress = "10.0.0.17";
    localAddress = "10.0.0.18";
  
      # mounts
    bindMounts = {
      "/var/lib/transmission" = {
        hostPath = "/var/lib/transmission";
        isReadOnly = false;
      };
    };
  
    forwardPorts = [
			{
				containerPort = 9091;
				hostPort = 9091;
				protocol = "tcp";
			}
		];

    config = { config, pkgs, ... }: {

      system.stateVersion = "22.11";
      networking.hostName = "transmission";

      services.transmission = {
        enable = true;
        home = "/var/lib/transmission";
        user = "transmission";
        group = "users";
        openFirewall = true;
        settings = {
          blocklist-enabled = true;
          blocklist-url = "http://list.iblocklist.com/?list=ydxerpxkpcfqjaybcssw&fileformat=p2p&archiveformat=gz";
          incomplete-dir-enabled = true;
          watch-dir-enabled = false;
          encryption = 1;
          message-level = 1;
          peer-port = 50778;
          peer-port-random-high = 65535;
          peer-port-random-low = 49152;
          peer-port-random-on-start = true;
          rpc-enable = true;
          rpc-bind-address = "0.0.0.0";
          rpc-port = 9091;
          rpc-authentication-required = true;
          rpc-username = "binette";
          rpc-password = "cd";
          rpc-whitelist-enabled = false;
          umask = 18;
          utp-enabled = true;
        };
      };
    };
  };

}

