{
  description = "NixOS Configuration";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    impermanence.url = "github:nix-community/impermanence";
    lanzaboote.url = "github:nix-community/lanzaboote";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , home-manager
    , impermanence
    , lanzaboote
    ,
    } @ inputs:
    let
      secrets = import ./secrets.nix;
      packages = system: import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      extra-packages = system: import ./extra-packages (packages system);
    in
    {
      nixosConfigurations = {
        Skipper = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          pkgs = packages system;
          specialArgs = inputs // { inherit secrets; extra-packages = (extra-packages system); };
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
                extraSpecialArgs = inputs // { inherit secrets; extra-packages = (extra-packages system); };
                users.${secrets.users.primary.userName} = _: {
                  imports = [
                    impermanence.nixosModules.home-manager.impermanence
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
    {
      formatter = pkgs.nixpkgs-fmt;
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          git
          git-crypt
          statix
        ];
      };
    }
    );
}
