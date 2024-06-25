{
  description = "NixOS Configuration for Skipper";

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
    nixos-hardware.url = "github:NixOS/nixos-hardware?ref=master";
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
    , nixos-hardware
    , sops-nix
    , flake-utils
    , neovim-nightly
    , varnam-nix
    ,
    } @ inputs:
    let
      lib = nixpkgs.lib;
      packages = system: import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [ varnam-nix.overlays.default (import ./extra-packages) ];
      };
    in
    {
      nixosConfigurations = {
        Skipper =
          let
            hostname = "Skipper";
            system = "x86_64-linux";
            username = "adtya";
          in
          nixpkgs.lib.nixosSystem {
            inherit system;
            pkgs = packages system;
            specialArgs = { inherit inputs username; };
            modules = [
              {
                system.configurationRevision = lib.mkIf (self ? rev) self.rev;
                networking.hostName = lib.mkDefault hostname;
                nixpkgs.hostPlatform = lib.mkDefault system;
              }
              lix-module.nixosModules.default
              sops-nix.nixosModules.sops
              lanzaboote.nixosModules.lanzaboote
              impermanence.nixosModules.impermanence
              home-manager.nixosModules.home-manager
              ./common
              ./hosts/skipper
              ./home

              {
                boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
              }
            ];
          };
        Rico1 =
          let
            hostname = "Rico1";
            system = "aarch64-linux";
            username = "adtya";
          in
          nixpkgs.lib.nixosSystem {
            inherit system;
            pkgs = packages system;
            specialArgs = { inherit inputs username; };
            modules = [
              {
                system.configurationRevision = lib.mkIf (self ? rev) self.rev;
                networking.hostName = lib.mkDefault hostname;
                nixpkgs.hostPlatform = lib.mkDefault system;
              }
              lix-module.nixosModules.default
              sops-nix.nixosModules.sops
              nixos-hardware.nixosModules.raspberry-pi-4
              ./common
              ./hosts/rico1
            ];
          };
        PiInstaller =
          let
            hostname = "PiInstaller";
            system = "aarch64-linux";
            username = "adtya";
          in
          lib.nixosSystem {
            inherit system;
            pkgs = packages system;
            specialArgs = { inherit inputs username; };
            modules = [
              {
                system.configurationRevision = lib.mkIf (self ? rev) self.rev;
                networking.hostName = lib.mkDefault hostname;
                nixpkgs.hostPlatform = lib.mkDefault system;
              }
              nixos-hardware.nixosModules.raspberry-pi-4
              ./common/nix.nix
              ./sdimage/piinstaller
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
      packages.getpaper = pkgs.callPackage ./extra-packages/scripts/getpaper;
    }
    );
}
