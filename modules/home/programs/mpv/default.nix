{ pkgs, config, lib, ... }:
with lib;

let
  cfg = config.modules.programs.mpv;
in
{
  options.modules.programs.mpv = {
    enable = mkOption {
      description = "Enable mpv package";
      type = types.bool;
      default = false;
    };
  };

  config = mkIf (cfg.enable) {
    programs.mpv = {
      enable = true;

      bindings = {
        "q" = "quit";
        "Q" = "quit-watch-later"; # exit and remember the playback position
        "l" = "seek 5";
        "h" = "seek -5";
        "p" = "cycle pause";
        "j" = "seek -60";
        "k" = "seek +60";

        "u" = "add sub-delay -0.1";
        "Shift+u" = "add sub-delay +0.1";

        "-" = "add volume -5";
        "=" = "add volume 5";

        "s" = "cycle sub";
        "Shift+s" = "cycle sub down";

        "f" = "cycle fullscreen";

        "r" = "async screenshot";
        "Shift+r" = "async screenshot video";
      };

      config = {

        /* --General-- */

          # Default profile
          # Can cause performance problems with some GPU drivers and GPUs.
        profile = "gpu-hq";
          # Uses GPU-accelerated video output by default
        vo = "gpu";

        /* ===== REMOVE THE ABOVE FIVE LINES AND RESAVE IF YOU ENCOUNTER PLAYBACK ISSUES AFTER ===== */

          # Volkan settings
        gpu-api = "vulkan";
        vulkan-async-compute = "yes";
        vulkan-async-transfer = "yes";
        vulkan-queue-count = 1;
        vd-lavc-dr = "yes";

          # Enable HW decoder; "false" for software decoding
          # "auto" "vaapi" "nvdec-copy"
        hwdec = "nvdec-copy";

        /* ---Audio--- */

          # Set default audio volume to 70%
        volume = 70;
        volume-max = 100;

        /* ---Languages--- */

        alang = "ja,jp,jpn,en,eng";
        slang = "en,eng";

        /* ---Screenshot--- */

        screenshot-directory = "~/pictures/screenshots";
        screenshot-template = "%F-%P";
        screenshot-format = "png"; # to test
        screenshot-sw = true; # to test

        /* ---UI--- */

          # osc
        no-osc = "";
        no-osd-bar = "";
        osd-font-size = 16;
        osd-border-size = 2;

          # Hide the window title bar
        no-border = "";
          # Color log messages on terminal
        msg-color = "yes";
          # displays a progress bar on the terminal
        term-osd-bar = "yes";
          # autohide the curser after 1s
        cursor-autohide = 1000;
        keep-open = "";
        force-window = "immediate";
        autofit = "50%x50%";
        geometry = "90%:5%";

        /* ---Subtitles--- */

        demuxer-mkv-subtitle-preroll = true;
        sub-font-size = 52;
        sub-blur = 0.2;
        sub-color = "1.0/1.0/1.0/1.0";
        sub-margin-x = 100;
        sub-margin-y = 50;
        sub-shadow-color = "0.0/0.0/0.0/0.25";
        sub-shadow-offset = 0;

        /* ---Scaling--- */
#        linear-downscaling = true;
#        linear-upscaling = true;
#        sigmoid-upscaling = true;
#        scale-antiring = 0.7;
#        dscale-antiring = 0.7;
#        cscale-antiring = 0.7;

          # https://gist.github.com/igv/
          # https://gist.github.com/agyild/
          # scaler / shader
        gpu-shader-cache-dir = "./shaders/cache";
        #glsl-shader="~~/shaders/SSimSuperRes.glsl"
        glsl-shader = [ "./shaders/FSR.glsl" "./shaders/SSimDownscaler.glsl" ];

        scale = "ewa_lanczossharp";
        dscale = "lanczos";
        linear-downscaling = "no";

        /* ---Motion Interpolation--- */
        video-sync = "display-resample";
        interpolation = true;
        tscale = "oversample"; # smoothmotion

        /* ---Misc--- */
        hr-seek-framedrop = "no";
        force-seekable = "";
        no-input-default-bindings = "";
        no-taskbar-progress = "";
        reset-on-next-file = "pause";
        msg-level = "input=error,demux=error";
        #quiet = "";
      };

      profiles = {
      };
    };
  };

}
