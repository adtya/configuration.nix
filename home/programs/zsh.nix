{ config
, pkgs
, ...
}:
let
  gnome-keyring-daemon = "${pkgs.gnome.gnome-keyring}/bin/gnome-keyring-daemon";
  hyprland = "${config.wayland.windowManager.hyprland.finalPackage}/bin/Hyprland";
in
{
  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    history = {
      expireDuplicatesFirst = true;
      extended = true;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
    };
    initExtra = ''
      bindkey -v '^?' backward-delete-char

      eval $(${gnome-keyring-daemon} -s -d 2> /dev/null)
      export SSH_AUTH_SOCK
    '';
    profileExtra = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ] ; then
        exec ${hyprland}
      fi
    '';
    shellAliases = {
      cat = "${pkgs.bat}/bin/bat";
      cp = "cp -v";
      grep = "grep --color=auto";
      ln = "ln -v";
      mv = "mv -v";
      rebuild_system = "sudo nixos-rebuild --flake /persist/home/.config/nixos#Skipper --cores 0";
    };
  };
}
