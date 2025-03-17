{ inputs, username, ... }:
{
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs username; };
    users.${username} = _: {
      imports = [
        ./programs
        ./services
        ./wm
        ./gtk.nix
        ./qt.nix
        ./xdg.nix
      ];
      home.stateVersion = "23.11";
    };
  };
}
