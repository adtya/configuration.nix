{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    history = {
      expireDuplicatesFirst = true;
      extended = true;
      ignoreDups = true;
      ignoreSpace = true;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
    };
    envExtra = lib.optionalString config.services.gnome-keyring.enable ''export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/keyring/ssh"'';
    initExtra = ''
      bindkey -v '^?' backward-delete-char
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
