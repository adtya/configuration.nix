{ config, pkgs, ... }: {

  xdg.desktopEntries."btop".name = "btop++";
  xdg.desktopEntries."btop".exec = "btop";
  xdg.desktopEntries."btop".noDisplay = true;

  programs = {
    bat = {
      enable = true;
      config = {
        theme = "Dracula";
      };
    };
    btop = {
      enable = true;
      settings = {
        color_theme = "dracula";
        vim_keys = true;
        update_ms = 1000;
      };
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    exa = {
      enable = true;
      enableAliases = true;
      extraOptions = [ "--group-directories-first" "--group" ];
      git = true;
      icons = true;
    };
    fzf.enable = true;
    starship = {
      enable = true;
      settings = {
        add_newline = false;
        git_metrics.disabled = false;
      };
    };
    zoxide.enable = true;
    zsh = {
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
        rebuild_system = "sudo nixos-rebuild --flake /persist/home/.nixos-config# --cores 0 --max-jobs 8";
      };
    };
  };
}