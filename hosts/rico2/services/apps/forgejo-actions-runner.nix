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
      aarch64-runner = {
        enable = true;
        name = "aarch64-runner";
        labels = [
          "docker:docker://ubuntu:latest"
          "aarch64-docker:docker://ubuntu:latest"
          "linux:docker://ubuntu:latest"
          "aarch64-linux:docker://ubuntu:latest"
        ];
        tokenFile = config.sops.secrets."forgejo/runner_registration_token_file".path;
        url = "https://forge.acomputer.lol";
        settings = {
          log.level = "info";
          cache = {
            enabled = false;
          };
        };
      };
    };
  };
}
