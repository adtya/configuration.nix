{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    history = {
      expireDuplicatesFirst = true;
      extended = true;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
    };
    initExtra = ''
      bindkey -v '^?' backward-delete-char
    '';
    profileExtra = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ] ; then
        exec ${config.wayland.windowManager.hyprland.package}/bin/Hyprland
      fi
    '';
    shellAliases = {
      cat = "bat";
      cd = "z";
      cp = "cp -v";
      grep = "grep --color=auto";
      ln = "ln -v";
      mv = "mv -v";
      rebuild_system = "sudo nixos-rebuild --flake /persist/home/.nixos-config#Skipper --cores 0 --max-jobs 8";
    };
  };
}
