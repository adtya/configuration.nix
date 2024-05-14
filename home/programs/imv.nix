{ pkgs, ... }: {
  programs.imv = {
    enable = true;
    package = pkgs.imv.overrideAttrs (new: old: {
      postInstall = old.postInstall + ''
        rm $out/share/applications/imv-dir.desktop
      '';
    });
  };
}
