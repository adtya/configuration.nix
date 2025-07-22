{ lib, pkgs, ... }:
{
  virtualisation = {
    containers = {
      enable = true;
      containersConf.settings = {
        engine = {
          compose_providers = [ (lib.getExe pkgs.docker-compose) ];
          compose_warning_logs = false;
        };
      };
      registries.search = [ "docker.io" ];
      storage.settings = {
        storage.driver = "btrfs";
      };
    };
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };
  };
  nodeconfig.users.primary.extra-groups = [ "podman" ];
}
