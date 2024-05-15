{ pkgs, ... }: {
  programs.imv = {
    enable = true;
    package = pkgs.imv.overrideAttrs (new: old: {
      postInstall = old.postInstall + ''
        rm $out/share/applications/imv.desktop
      '';
    });
    settings = {
      options = {
        background = "282a36";
        overlay_background_color = "44475a";
        overlay_text_color = "f8f8f2";
      };
    };
  };
}
