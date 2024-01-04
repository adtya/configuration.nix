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
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };

    adtyaxyz = {
      url = "github:adtya/adtya.xyz";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };

    wiki = {
      url = "github:adtya/wiki";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };

    if3 = {
      url = "github:adtya/if3-docs";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , home-manager
    , impermanence
    , lanzaboote
    , nixos-hardware
    , nixvim
    , adtyaxyz
    , wiki
    , if3
    ,
    } @ inputs:
    let
      secrets = import ./secrets.nix;
      nixpkgs-config = {
        allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        Skipper = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          pkgs = import nixpkgs {
            inherit system;
            config = nixpkgs-config;
            overlays = [ (import ./packages) ];
          };
          specialArgs = inputs // { inherit secrets; };
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
                extraSpecialArgs = { inherit secrets; };
                users.${secrets.users.primary.userName} = { pkgs, ... }: {
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
        Rico0 = nixpkgs.lib.nixosSystem rec {
          system = "aarch64-linux";
          pkgs = import nixpkgs {
            inherit system;
            config = nixpkgs-config;
          };
          specialArgs = inputs // { inherit secrets; };
          modules = [
            {
              system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
            }

            nixos-hardware.nixosModules.raspberry-pi-4

            ./common
            ./hosts/rico0
          ];
        };
        Rico1 = nixpkgs.lib.nixosSystem rec {
          system = "aarch64-linux";
          pkgs = import nixpkgs {
            inherit system;
            config = nixpkgs-config;
          };
          specialArgs = inputs // { inherit secrets; };
          modules = [
            {
              system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
            }

            nixos-hardware.nixosModules.raspberry-pi-4

            ./common
            ./hosts/rico1
          ];
        };
        Rico2 = nixpkgs.lib.nixosSystem rec {
          system = "aarch64-linux";
          pkgs = import nixpkgs {
            inherit system;
            config = nixpkgs-config;
          };
          specialArgs = inputs // { inherit secrets; };
          modules = [
            {
              system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
            }

            nixos-hardware.nixosModules.raspberry-pi-4

            ./common
            ./hosts/rico2
          ];
        };
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      with pkgs; {
        formatter = nixpkgs-fmt;
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
