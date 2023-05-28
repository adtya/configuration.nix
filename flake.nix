{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixneovim = {
      url = "github:adtya/nixneovim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    impermanence,
    lanzaboote,
    nixneovim,
  } @ inputs: {
    formatter."x86_64-linux" = nixpkgs.legacyPackages."x86_64-linux".alejandra;
    nixosConfigurations = let
      user = (import ./secrets.nix).users;
    in {
      Skipper = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        pkgs = import nixpkgs {
          inherit system;
          config = {allowUnfree = true;};
          overlays = [(import ./packages) nixneovim.overlays.default];
        };
        specialArgs = inputs;
        modules = [
          {
            system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
          }

          home-manager.nixosModules.home-manager
          impermanence.nixosModules.impermanence
          lanzaboote.nixosModules.lanzaboote

          ./common
          ./hosts/skipper

          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              users.${user.primary.userName} = {pkgs, ...}: {
                imports = [
                  impermanence.nixosModules.home-manager.impermanence
                  nixneovim.nixosModules.default
                  ./home
                ];
              };
            };
          }
        ];
      };
      Rico2 = nixpkgs.lib.nixosSystem rec {
        system = "aarch64-linux";
        pkgs = import nixpkgs {
          inherit system;
          config = {allowUnfree = true;};
        };
        specialArgs = inputs;
        modules = [
          {
            system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
          }
          ./common
          ./hosts/rico2
        ];
      };
    };
  };
}
