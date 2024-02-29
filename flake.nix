{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    impermanence.url = "github:nix-community/impermanence";
    lanzaboote.url = "github:nix-community/lanzaboote";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , home-manager
    , impermanence
    , lanzaboote
    , neovim-nightly
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
            overlays = [ (import ./packages) neovim-nightly.overlay ];
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
