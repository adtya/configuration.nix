{
  config,
  pkgs,
  ...
}: {
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
    profileExtra =
      if pkgs.stdenv.isLinux
      then ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ] ; then
          exec ${pkgs.hyprland}/bin/Hyprland
        fi
      ''
      else "";
    shellAliases = {
      cat = "bat";
      cp = "cp -v";
      grep = "grep --color=auto";
      ln = "ln -v";
      mv = "mv -v";
      rebuild_system =
        if pkgs.stdenv.isLinux
        then "sudo nixos-rebuild --flake /persist/home/.nixos-config#Skipper --cores 0"
        else "home-manager --flake /Users/adtya/Projects/nixos-config#adtya@Alex --cores 0";
    };
  };
}
