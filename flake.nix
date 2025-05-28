{
  description = "My NixOS Recipes";

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
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0-3.tar.gz";
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
    caddy-hetzner.url = "github:/adtya/caddy-hetzner?ref=main";
    smc-fonts.url = "gitlab:smc/smc-fonts-flake?ref=trunk";
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
          overlays = [
            (import ./packages)
            inputs.recipes.overlays.default
          ];
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
              inputs.recipes.nixosModules.default
              inputs.self.nixosModules.default
            ];
            sops.defaultSopsFile = ./secrets.yaml;
            system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
            networking = {
              hostName = lib.mkDefault hostname;
              hostId = lib.mkDefault hostId;
            };
            nixpkgs.hostPlatform = lib.mkDefault system;
          };
        in
        {
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
                ./hosts/skipper
                ./home
              ];
            };
          Gwen =
            let
              hostname = "Gwen";
              hostId = "dfb83801";
              system = "x86_64-linux";
            in
            lib.nixosSystem {
              inherit system;
              pkgs = pkgsFor system;
              specialArgs = { inherit inputs primary-user; };
              modules = [
                (common-module hostname hostId system)
                ./hosts/gwen
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
                ./hosts/rico0
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
                ./hosts/rico1
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
                ./hosts/rico2
              ];
            };
          Wynne =
            let
              hostname = "Wynne";
              hostId = "dfb83813";
              system = "x86_64-linux";
            in
            lib.nixosSystem {
              inherit system;
              pkgs = pkgsFor system;
              specialArgs = { inherit inputs primary-user; };
              modules = [
                (common-module hostname hostId system)
                ./hosts/wynne
              ];
            };
          Layne =
            let
              hostname = "Layne";
              hostId = "dfb83814";
              system = "x86_64-linux";
            in
            lib.nixosSystem {
              inherit system;
              pkgs = pkgsFor system;
              specialArgs = { inherit inputs primary-user; };
              modules = [
                (common-module hostname hostId system)
                ./hosts/layne
              ];
            };
          Bifrost =
            let
              hostname = "Bifrost";
              hostId = "dfb83815";
              system = "x86_64-linux";
            in
            lib.nixosSystem {
              inherit system;
              pkgs = pkgsFor system;
              specialArgs = { inherit inputs primary-user; };
              modules = [
                (common-module hostname hostId system)
                ./hosts/bifrost
              ];
            };
        };

      deploy.nodes =
        let
          deploy = inputs.deploy-rs.lib;
          hosts = inputs.self.nixosConfigurations;
          hostArch = {
            Skipper = "x86_64-linux";
            Gwen = "x86_64-linux";
            Rico0 = "aarch64-linux";
            Rico1 = "aarch64-linux";
            Rico2 = "aarch64-linux";
            Wynne = "x86_64-linux";
            Layne = "x86_64-linux";
            Bifrost = "X86_64-linux";
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
