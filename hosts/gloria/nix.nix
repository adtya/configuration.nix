{ username, ... }: {
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [ username  "@admin" ];
    };
  };

}
