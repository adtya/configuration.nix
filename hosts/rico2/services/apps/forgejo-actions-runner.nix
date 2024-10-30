{ pkgs, config, ... }: {
  sops.secrets = {
    "forgejo/runner_registration_token_file" = {
      mode = "400";
      owner = config.users.users.root.name;
      group = config.users.users.root.group;
    };
  };
  services.gitea-actions-runner = {
    package = pkgs.forgejo-runner;
    instances = {
      runner-arm64 = {
        enable = true;
        name = "runner-arm64";
        labels = [
          "docker:docker://debian-stable"
          "docker-arm64:docker://debian-stable"
        ];
        tokenFile = config.sops.secrets."forgejo/runner_registration_token_file".path;
        url = "https://forge.acomputer.lol";
      };
    };
  };
}
