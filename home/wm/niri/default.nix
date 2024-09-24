{ lib, pkgs, config, ... }: {
  home.packages = [ pkgs.niri ];
  xdg.portal = {
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    configPackages = [ pkgs.niri ];
    config = {
      niri = {
        default = [ "gnome" "gtk" ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      };
    };
  };

  programs.zsh.profileExtra = ''
    if [ -z $DISPLAY ] && [ -z $WAYLAND_DISPLAY ] && [ "$(tty)" = "/dev/tty1" ] ; then
      exec ${lib.getExe pkgs.niri} --session
    fi
  '';

  xdg.configFile."niri/config.kdl".source = pkgs.substituteAll {
    src = ./config.kdl;
    dbus_update_activation_env_cmd = "${pkgs.dbus}/bin/dbus-update-activation-environment";
    systemctl_cmd = "${pkgs.systemd}/bin/systemctl";
    loginctl_cmd = "${pkgs.systemd}/bin/loginctl";
    wpaperctl_cmd = "${pkgs.wpaperd}/bin/wpaperctl";
    kitty_cmd = "${lib.getExe pkgs.kitty}";
    tmux_cmd = "${lib.getExe pkgs.tmux}";
    rofi_cmd = "${lib.getExe config.programs.rofi.package}";
    yazi_cmd = "${lib.getExe pkgs.yazi}";
    firefox_cmd = "${lib.getExe config.programs.firefox.finalPackage}";
    librewolf_cmd = "${lib.getExe pkgs.librewolf}";
    wpctl_cmd = "${pkgs.wireplumber}/bin/wpctl";
    brightnessctl_cmd = "${lib.getExe pkgs.brightnessctl}";
    swaync_client_cmd = "${pkgs.swaynotificationcenter}/bin/swaync-client";

    power_menu_cmd = "${pkgs.misc-scripts}/bin/power-menu";
    tmux_sessions_cmd = "${pkgs.misc-scripts}/bin/tmux-sessions";
    youtube_cmd = "${pkgs.youtube}/bin/youtube";
    bluetooth_cmd = "${pkgs.rofi-bluetooth}/bin/rofi-bluetooth";

    screenshot_path = "${config.xdg.userDirs.pictures}/Screenshots";
  };

  systemd.user = {
    targets.niri-session = {
      Unit = {
        After = [ "graphical-session-pre.target" ];
        BindsTo = [ "graphical-session.target" ];
        Description = "Niri compositor session";
        Documentation = "man:systemd.special(7)";
        Wants = [ "graphical-session-pre.target" ];
      };
    };
    targets.niri-shutdown = {
      Unit = {
        Description = "Shutdown running niri session";
        DefaultDependencies = "no";
        StopWhenUnneeded = true;

        Conflicts = [ "graphical-session.target" "graphical-session-pre.target" ];
        After = [ "graphical-session.target" "graphical-session-pre.target" ];
      };
    };
  };
}
