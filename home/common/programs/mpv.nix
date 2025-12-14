{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;
    package = pkgs.mpv.override {
      youtubeSupport = true;
      scripts = with pkgs.mpvScripts; [ mpris ];
    };
    config = {
      border = "no";
      cache = "yes";
      cache-secs = "120";
      hwdec = "auto-safe";
      ao = "pipewire";
      vo = "gpu-next";
      gpu-context = "waylandvk";
      gpu-api = "vulkan";
      vulkan-async-compute = "yes";
      vulkan-async-transfer = "yes";
      target-colorspace-hint = "yes";
    };
    defaultProfiles = [ "gpu-hq" ];
  };

  xdg.desktopEntries = {
    "umpv" = {
      name = "umpv Media Player";
      exec = "umpv --player-operation-mode=pseudo-gui -- %U";
      noDisplay = true;
    };
  };
}
