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
    sops-nix.url = "github:Mic92/sops-nix?ref=master";
    deploy-rs.url = "github:serokell/deploy-rs?ref=master";
    flake-utils.url = "github:numtide/flake-utils?ref=main";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay?ref=master";
    varnam-nix.url = "github:adtya/varnam-nix?ref=main";
    adtyaxyz.url = "github:adtya/adtya.xyz?ref=main";
    wiki.url = "github:adtya/wiki?ref=main";
  };

  outputs =
    { self
    , nixpkgs
    , lix-module
    , home-manager
    , impermanence
    , lanzaboote
    , sops-nix
    , deploy-rs
    , flake-utils
    , neovim-nightly
    , varnam-nix
    , adtyaxyz
    , wiki
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
            ];
          };
        Rico0 =
          let
            hostname = "Rico0";
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
              ./common
              ./hosts/rico0
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
              ./common
              ./hosts/rico1
            ];
          };
        Rico2 =
          let
            hostname = "Rico2";
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
              ./common
              ./hosts/rico2
            ];
          };
        Wynne =
          let
            hostname = "Wynne";
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
              ./common
              ./hosts/wynne
            ];
          };
        Layne =
          let
            hostname = "Layne";
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
              ./common
              ./hosts/layne
            ];
          };
      };

      deploy.nodes = {
        Rico0 = {
          hostname = "Rico0";
          sshUser = "adtya";
          remoteBuild = true;
          profiles.system = {
            user = "root";
            path = deploy-rs.lib.aarch64-linux.activate.nixos self.nixosConfigurations.Rico0;
          };
        };
        Rico1 = {
          hostname = "Rico1";
          sshUser = "adtya";
          remoteBuild = true;
          profiles.system = {
            user = "root";
            path = deploy-rs.lib.aarch64-linux.activate.nixos self.nixosConfigurations.Rico1;
          };
        };
        Rico2 = {
          hostname = "Rico2";
          sshUser = "adtya";
          remoteBuild = true;
          profiles.system = {
            user = "root";
            path = deploy-rs.lib.aarch64-linux.activate.nixos self.nixosConfigurations.Rico2;
          };
        };
        Wynne = {
          hostname = "Wynne";
          sshUser = "adtya";
          profiles.system = {
            user = "root";
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.Wynne;
          };
        };
        Layne = {
          hostname = "Layne";
          sshUser = "adtya";
          profiles.system = {
            user = "root";
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.Layne;
          };
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
          deploy-rs.packages.${pkgs.system}.default
        ];
      };
      packages.getpaper = pkgs.callPackage ./extra-packages/scripts/getpaper { };
    }
    );
}
