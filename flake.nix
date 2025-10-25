{
  description = "My NixOS Recipes";

  nixConfig = {
    extra-substituters = [
      "https://adtya.cachix.org"
      "https://cache.soopy.moe"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "adtya.cachix.org-1:lAuNLx0Ehzx6FoH20rVkMD7KyZZevlLfvm3lwMAzrnU="
      "cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager?ref=master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    disko.url = "github:nix-community/disko?ref=latest";
    impermanence.url = "github:nix-community/impermanence?ref=master";
    lanzaboote.url = "github:nix-community/lanzaboote?ref=master";
    sops-nix.url = "github:Mic92/sops-nix?ref=master";
    deploy-rs.url = "github:serokell/deploy-rs?ref=master";
    flake-utils.url = "github:numtide/flake-utils?ref=main";
    treefmt-nix.url = "github:numtide/treefmt-nix?ref=main";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay?ref=master";
    smc-fonts.url = "gitlab:smc/smc-fonts-flake?ref=trunk";
    adtyaxyz.url = "github:adtya/adtya.xyz?ref=main";
    wiki.url = "github:adtya/wiki?ref=main";
  };

  outputs =
    inputs:
    let
      inherit (inputs.nixpkgs) lib;
      forAllSystems = lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      pkgsFor =
        system:
        import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [ (import ./packages) ];
        };
    in
    {
      formatter = forAllSystems (
        system:
        (import ./formatter.nix {
          pkgs = pkgsFor system;
          inherit (inputs) treefmt-nix;
        })
      );

      devShells = forAllSystems (
        system:
        (import ./devshells.nix {
          pkgs = pkgsFor system;
          inherit (inputs) deploy-rs;
        })
      );

      packages = forAllSystems (
        system:
        (import ./packages.nix {
          pkgs = pkgsFor system;
          inherit (inputs) nixpkgs;
        })
      );

      nixosModules.default = import ./modules;

      nixosConfigurations =
        let
          primary-user = {
            name = "adtya";
            long-name = "Adithya Nair";
            email = "adtya@adtya.xyz";
          };
          common-module = hostname: hostId: system: {
            imports = [
              inputs.sops-nix.nixosModules.sops
              inputs.self.nixosModules.default
            ];
            sops.defaultSopsFile = ./secrets.yaml;
            system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
            networking = {
              hostName = lib.mkForce hostname;
              hostId = lib.mkForce hostId;
            };
            nixpkgs.hostPlatform = lib.mkDefault system;
          };
        in
        {
          Gloria =
            let
              hostname = "Gloria";
              hostId = "dfb83799";
              system = "x86_64-linux";
            in
            lib.nixosSystem {
              inherit system;
              pkgs = pkgsFor system;
              specialArgs = { inherit inputs primary-user; };
              modules = [
                (common-module hostname hostId system)
                ./hosts/gloria.nix
                ./home/gloria.nix
              ];
            };
          Skipper =
            let
              hostname = "Skipper";
              hostId = "dfb83800";
              system = "x86_64-linux";
            in
            lib.nixosSystem {
              inherit system;
              pkgs = pkgsFor system;
              specialArgs = { inherit inputs primary-user; };
              modules = [
                (common-module hostname hostId system)
                ./hosts/skipper.nix
                ./home/skipper.nix
              ];
            };
          Thor =
            let
              hostname = "Thor";
              hostId = "dfb83801";
              system = "x86_64-linux";
            in
            lib.nixosSystem {
              inherit system;
              pkgs = pkgsFor system;
              specialArgs = { inherit inputs primary-user; };
              modules = [
                (common-module hostname hostId system)
                ./hosts/thor.nix
                ./home/thor.nix
              ];
            };
          Bifrost =
            let
              hostname = "Bifrost";
              hostId = "dfb83802";
              system = "x86_64-linux";
            in
            lib.nixosSystem {
              inherit system;
              pkgs = pkgsFor system;
              specialArgs = { inherit inputs primary-user; };
              modules = [
                (common-module hostname hostId system)
                ./hosts/bifrost.nix
              ];
            };
          Rico0 =
            let
              hostname = "Rico0";
              hostId = "dfb83810";
              system = "aarch64-linux";
            in
            lib.nixosSystem {
              inherit system;
              pkgs = pkgsFor system;
              specialArgs = { inherit inputs primary-user; };
              modules = [
                (common-module hostname hostId system)
                ./hosts/rico0.nix
              ];
            };
          Rico1 =
            let
              hostname = "Rico1";
              hostId = "dfb83811";
              system = "aarch64-linux";
            in
            lib.nixosSystem {
              inherit system;
              pkgs = pkgsFor system;
              specialArgs = { inherit inputs primary-user; };
              modules = [
                (common-module hostname hostId system)
                ./hosts/rico1.nix
              ];
            };
          Rico2 =
            let
              hostname = "Rico2";
              hostId = "dfb83812";
              system = "aarch64-linux";
            in
            lib.nixosSystem {
              inherit system;
              pkgs = pkgsFor system;
              specialArgs = { inherit inputs primary-user; };
              modules = [
                (common-module hostname hostId system)
                ./hosts/rico2.nix
              ];
            };
        };

      deploy.nodes =
        let
          deploy = inputs.deploy-rs.lib;
          hosts = inputs.self.nixosConfigurations;
          hostArch = {
            Skipper = "x86_64-linux";
            Thor = "x86_64-linux";
            Bifrost = "x86_64-linux";
            Rico0 = "aarch64-linux";
            Rico1 = "aarch64-linux";
            Rico2 = "aarch64-linux";
          };
          deployConfig = hostname: arch: {
            inherit hostname;
            sshUser = "adtya";
            profiles.system = {
              user = "root";
              path = deploy.${arch}.activate.nixos hosts.${hostname};
            };
          };
        in
        lib.mapAttrs deployConfig hostArch;
    };
}
