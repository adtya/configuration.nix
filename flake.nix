{
  description = "NixOS Configuration for Skipper";

  nixConfig = {
    extra-substituters = [
      "https://adtya.cachix.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "adtya.cachix.org-1:lAuNLx0Ehzx6FoH20rVkMD7KyZZevlLfvm3lwMAzrnU="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager?ref=master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko.url = "github:nix-community/disko?ref=latest";
    impermanence.url = "github:nix-community/impermanence?ref=master";
    lanzaboote.url = "github:nix-community/lanzaboote?ref=master";
    sops-nix.url = "github:Mic92/sops-nix?ref=master";
    deploy-rs.url = "github:serokell/deploy-rs?ref=master";
    flake-utils.url = "github:numtide/flake-utils?ref=main";
    treefmt-nix.url = "github:numtide/treefmt-nix?ref=main";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay?ref=master";
    adtyaxyz.url = "github:/adtya/adtya.xyz?ref=main";
    wiki.url = "github:/adtya/wiki?ref=main";
    recipes.url = "github:/adtya/recipes.nix?ref=main";
    smc-fonts.url = "gitlab:smc/smc-fonts-flake?ref=trunk";
  };

  outputs =
    {
      self,
      nixpkgs,
      lix-module,
      nix-darwin,
      home-manager,
      disko,
      impermanence,
      lanzaboote,
      sops-nix,
      deploy-rs,
      flake-utils,
      treefmt-nix,
      neovim-nightly,
      adtyaxyz,
      wiki,
      recipes,
      smc-fonts,
    }@inputs:
    let
      inherit (nixpkgs) lib;
      packages =
        system:
        import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            permittedInsecurePackages = [
              "aspnetcore-runtime-6.0.36"
              "dotnet-sdk-6.0.428"
            ];
          };
          overlays = [
            (import ./packages)
            recipes.overlays.default
          ];
        };
    in
    {
      nixosModules.default = import ./modules;
      darwinConfigurations.Gloria =
        let
          hostname = "Gloria";
          system = "x86_64-darwin";
          username = "adtya";
        in
        nix-darwin.lib.darwinSystem {
          inherit system;
          pkgs = packages system;
          specialArgs = { inherit inputs username; };
          modules = [
            {
              system.configurationRevision = self.rev or self.dirtyRev or null;
              networking.hostName = lib.mkDefault hostname;
              nixpkgs.hostPlatform = lib.mkDefault system;
            }
            home-manager.darwinModules.home-manager
            ./hosts/gloria
          ];
        };
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
                system.configurationRevision = self.rev or self.dirtyRev or null;
                networking.hostName = lib.mkDefault hostname;
                nixpkgs.hostPlatform = lib.mkDefault system;
              }
              lix-module.nixosModules.default
              sops-nix.nixosModules.sops
              disko.nixosModules.disko
              impermanence.nixosModules.impermanence
              lanzaboote.nixosModules.lanzaboote
              home-manager.nixosModules.home-manager
              self.nixosModules.default
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
                system.configurationRevision = self.rev or self.dirtyRev or null;
                networking.hostName = lib.mkDefault hostname;
                nixpkgs.hostPlatform = lib.mkDefault system;
              }
              sops-nix.nixosModules.sops
              recipes.nixosModules.default
              self.nixosModules.default
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
                system.configurationRevision = self.rev or self.dirtyRev or null;
                networking.hostName = lib.mkDefault hostname;
                nixpkgs.hostPlatform = lib.mkDefault system;
              }
              sops-nix.nixosModules.sops
              recipes.nixosModules.default
              self.nixosModules.default
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
                system.configurationRevision = self.rev or self.dirtyRev or null;
                networking.hostName = lib.mkDefault hostname;
                nixpkgs.hostPlatform = lib.mkDefault system;
              }
              sops-nix.nixosModules.sops
              recipes.nixosModules.default
              self.nixosModules.default
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
                system.configurationRevision = self.rev or self.dirtyRev or null;
                networking.hostName = lib.mkDefault hostname;
                nixpkgs.hostPlatform = lib.mkDefault system;
              }
              sops-nix.nixosModules.sops
              recipes.nixosModules.default
              self.nixosModules.default
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
                system.configurationRevision = self.rev or self.dirtyRev or null;
                networking.hostName = lib.mkDefault hostname;
                nixpkgs.hostPlatform = lib.mkDefault system;
              }
              sops-nix.nixosModules.sops
              recipes.nixosModules.default
              self.nixosModules.default
              ./common
              ./hosts/layne
            ];
          };
        Bifrost =
          let
            hostname = "Bifrost";
            system = "x86_64-linux";
            username = "adtya";
          in
          nixpkgs.lib.nixosSystem {
            inherit system;
            pkgs = packages system;
            specialArgs = { inherit inputs username; };
            modules = [
              {
                system.configurationRevision = self.rev or self.dirtyRev or null;
                networking.hostName = lib.mkForce hostname;
                nixpkgs.hostPlatform = lib.mkDefault system;
              }
              sops-nix.nixosModules.sops
              recipes.nixosModules.default
              self.nixosModules.default
              ./common
              ./hosts/bifrost
            ];
          };
      };

      deploy.nodes = {
        Rico0 = {
          hostname = "Rico0";
          sshUser = "adtya";
          profiles.system = {
            user = "root";
            path = deploy-rs.lib.aarch64-linux.activate.nixos self.nixosConfigurations.Rico0;
          };
        };
        Rico1 = {
          hostname = "Rico1";
          sshUser = "adtya";
          profiles.system = {
            user = "root";
            path = deploy-rs.lib.aarch64-linux.activate.nixos self.nixosConfigurations.Rico1;
          };
        };
        Rico2 = {
          hostname = "Rico2";
          sshUser = "adtya";
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
        Bifrost = {
          hostname = "Bifrost";
          sshUser = "adtya";
          profiles.system = {
            user = "root";
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.Bifrost;
          };
        };
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        treeFmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
      in
      {
        formatter = treeFmtEval.config.build.wrapper;
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            git
            sops
            age
            ssh-to-age
            deploy-rs.packages.${pkgs.system}.default
          ];
        };
        packages.digitalOceanImage =
          (pkgs.nixos {
            imports = [ "${nixpkgs}/nixos/modules/virtualisation/digital-ocean-image.nix" ];
            system.stateVersion = "24.11";
          }).digitalOceanImage;
      }
    );
}
