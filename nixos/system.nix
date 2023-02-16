{ config, lib, pkgs, ... }:

{
  options.nixos.system.enable = lib.mkEnableOption "system config" // { default = true; };

  config = lib.mkIf config.nixos.system.enable {

    boot = {
        # Mount /tmp using tmpfs for performance
      tmpOnTmpfs = lib.mkDefault true;
        # If not using above, at least clean /tmp on each boot
      cleanTmpDir = lib.mkDefault true;
        # Enable NTFS support
      supportedFilesystems = [ "ntfs" ];
      kernel.sysctl = {
          # Enable Magic keys
        "kernel.sysrq" = 1;
         # Reduce swap preference
        "vm.swappiness" = 10;
      };
      /* --Silent boot-- */
      initrd.verbose = false;
      consoleLogLevel = 0;
      kernelParams = [ "quiet" "udev.log_level=3" /*"console=tty1"*/ ];
    };

      # Increase file handler limit
#    security.pam.loginLimits = [{
#      domain = "*";
#      type = "-";
#      item = "nofile";
#      value = "524288";
#    }];

      # Enable firmware-linux-nonfree
    hardware.enableRedistributableFirmware = true;


      # Nix auto cleanup and reduce disk
    nix = {
      gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 7d";
      };
      extraOptions = ''
        keep-outputs = true
        keep-derivations = true
     '';
        # Leave nix builds as a background task
      daemonIOSchedClass = "idle";
      daemonCPUSchedPolicy = "idle";
    };

    services = {
        #TODO: Trim SSD weekly
#      fstrim = {
#        enable = true;
#        interval = "weekly";
#      };

        # Decrease journal size
      journald.extraConfig = ''
        SystemMaxUse=500M
      '';

        # Suspend when power key is pressed
      logind.extraConfig = ''
        HandlePowerKey=suspend-then-hibernate
      '';

        # Enable NTP
      timesyncd.enable = lib.mkDefault true;

        # Enable smartd for SMART reporting
      smartd.enable = true;

        # Set I/O scheduler
        # kyber is set for NVMe, since scheduler doesn't make much sense on it
        # bfq for SATA SSDs/HDDs
      udev.extraRules = ''
        # set scheduler for NVMe
        ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/scheduler}="kyber"
        # set scheduler for SSD and eMMC
        ACTION=="add|change", KERNEL=="sd[a-z]|mmcblk[0-9]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="bfq"
        # set scheduler for rotating disks
        ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"
      '';
    };

    systemd = {
        # Reduce default service stop timeouts for faster shutdown
      extraConfig = ''
        DefaultTimeoutStopSec=15s
        DefaultTimeoutAbortSec=5s
      '';
        # systemd's out-of-memory daemon
      oomd = {
        enable = lib.mkDefault true;
        enableRootSlice = true;
        enableSystemSlice = true;
        enableUserServices = true;
      };
    };

      # Enable zram to have better memory management
#    zramSwap = {
#      enable = true;
#      algorithm = "zstd";
#    };
  };
}
