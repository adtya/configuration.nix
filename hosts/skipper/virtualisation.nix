{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.docker-credential-helpers ];
  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
  };
}
