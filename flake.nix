{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
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
      url = "github:adtya/nixvim/dracula-vim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    home-manager,
    impermanence,
    lanzaboote,
    nixvim,
  } @ inputs: let
    secrets = import ./secrets.nix;
    config = {
      allowUnfree = true;
    };
  in
    {
      nixosConfigurations = {
        Skipper = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          pkgs = import nixpkgs {
            inherit system;
            inherit config;
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
        Rico1 = nixpkgs.lib.nixosSystem rec {
          system = "aarch64-linux";
          pkgs = import nixpkgs {
            inherit system;
            inherit config;
          };
          specialArgs = inputs // {inherit secrets;};
          modules = [
            {
              system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
            }

            ./common
            ./hosts/rico1
          ];
        };
        Rico2 = nixpkgs.lib.nixosSystem rec {
          system = "aarch64-linux";
          pkgs = import nixpkgs {
            inherit system;
            inherit config;
          };
          specialArgs = inputs // {inherit secrets;};
          modules = [
            {
              system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
            }

            ./common
            ./hosts/rico2
          ];
        };
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
        with pkgs; {
          formatter = pkgs.alejandra;
          devShells.default = mkShell {
            buildInputs = [
              git
              git-crypt
              statix
            ];
          };
        }
    );
}
