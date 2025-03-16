{ inputs, username, ... }:
{
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs username; };
    users.${username} = {
      imports = [
        ./programs
        ./services
      ];
      xdg.enable = true;
      home.stateVersion = "25.05";
    };
  };
}
