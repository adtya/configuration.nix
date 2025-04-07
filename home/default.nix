{ inputs, primary-user, ... }:
{
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs primary-user; };
    users.${primary-user.name} = _: {
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
