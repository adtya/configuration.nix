{ inputs, primary-user, ... }:
{
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs primary-user; };
    users.${primary-user.name} = _: {
      imports = [
        ./common
        ./gloria
      ];
      home.stateVersion = "25.11";
    };
  };
}
