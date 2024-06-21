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
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    lix-module = {
      url = "git+https://git.lix.systems/lix-project/nixos-module?ref=release-2.90";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager?ref=master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence?ref=master";
    lanzaboote.url = "github:nix-community/lanzaboote?ref=master";
    sops-nix.url = "github:Mic92/sops-nix?ref=master";
    flake-utils.url = "github:numtide/flake-utils";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay?ref=master";
    varnam-nix.url = "github:adtya/varnam-nix?ref=main";
  };

  outputs =
    { self
    , nixpkgs
    , lix-module
    , home-manager
    , impermanence
    , lanzaboote
    , sops-nix
    , flake-utils
    , neovim-nightly
    , varnam-nix
    ,
    } @ inputs:
    let
      packages = system: import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [ varnam-nix.overlays.default ];
      };
      extra-packages = system: import ./extra-packages (packages system);
    in
    {
      nixosConfigurations = {
        Skipper = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          pkgs = packages system;
          specialArgs = inputs // { extra-packages = (extra-packages system); };
          modules = [
            {
              system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
            }
            lix-module.nixosModules.default
            home-manager.nixosModules.home-manager
            impermanence.nixosModules.impermanence
            lanzaboote.nixosModules.lanzaboote
            sops-nix.nixosModules.sops

            ./common
            ./hosts/skipper

            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = inputs // { extra-packages = (extra-packages system); };
                users.adtya = _: {
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
          statix
          sops
          age
        ];
      };
      packages.getpaper = (import ./extra-packages pkgs).getpaper;
    }
    );
}
