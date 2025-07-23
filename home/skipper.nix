{ inputs, primary-user, ... }:
{
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs primary-user; };
    users.${primary-user.name} = _: {
      imports = [
        ./common
        ./skipper
      ];
      home.stateVersion = "23.11";
    };
  };
}
