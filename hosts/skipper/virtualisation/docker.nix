{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.docker-credential-helpers ];
  virtualisation = {
    docker = {
      enable = true;
      daemon.settings = {
        data-root = "/persist/docker";
      };
      storageDriver = "btrfs";
    };
  };
}
