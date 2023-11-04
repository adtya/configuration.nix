{ config
, pkgs
, ...
}: {
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
    '';
    profileExtra =
      if pkgs.stdenv.isLinux
      then ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ] ; then
          exec ${pkgs.hyprland}/bin/Hyprland
        fi
      ''
      else "";
    shellAliases = {
      cat = "${pkgs.bat}/bin/bat";
      cp = "cp -v";
      grep = "grep --color=auto";
      ln = "ln -v";
      mv = "mv -v";
      rebuild_system = "sudo nixos-rebuild --flake /persist/home/.nixos-config#Skipper --cores 0";
    };
  };
}
