{ config, ... }:
{
  xdg.configFile."sops/age/keys.txt".source =
    config.lib.file.mkOutOfStoreSymlink "/persist/secrets/sops/age/keys.txt";
}
