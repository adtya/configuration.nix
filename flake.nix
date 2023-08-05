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

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    impermanence,
    lanzaboote,
    nixvim,
  } @ inputs: let
    secrets = import ./secrets-legacy.nix;
  in {
    formatter."x86_64-linux" = nixpkgs.legacyPackages."x86_64-linux".alejandra;
    nixosConfigurations = {
      Skipper = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
          overlays = [(import ./packages)];
        };
        specialArgs = inputs // {inherit secrets;};
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
              extraSpecialArgs = {inherit secrets;};
              users.${secrets.users.primary.userName} = {pkgs, ...}: {
                imports = [
                  impermanence.nixosModules.home-manager.impermanence
                  nixvim.homeManagerModules.nixvim
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
          config = {
            allowUnfree = true;
          };
        };
        specialArgs = inputs // {inherit secrets;};
        modules = [
          {
            system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
          }

          nixvim.nixosModules.nixvim

          ./common
          ./hosts/rico2
        ];
      };
    };
  };
}
