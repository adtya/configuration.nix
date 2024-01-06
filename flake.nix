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

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };

    flake_env = {
      url = "git+https://git.sr.ht/~bryan_bennett/flake_env";
      inputs = {
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
    , nixvim
    , flake_env
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
                extraSpecialArgs = inputs // { inherit secrets; };
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
      };
    }
    // flake-utils.lib.eachDefaultSystem (system:
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
