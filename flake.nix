{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
    };

    nixvim = {
      url = "github:pta2002/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, impermanence, lanzaboote, nixos-hardware, nixvim }@inputs: {
    formatter."x86_64-linux" = nixpkgs.legacyPackages."x86_64-linux".nixpkgs-fmt;
    formatter."aarch64-linux" = nixpkgs.legacyPackages."aarch64-linux".nixpkgs-fmt;
    nixosConfigurations = {
      Skipper = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [
          ./nix.nix

          {
            nixpkgs.overlays = [ (import ./packages) hyprland.overlays.default ];
            nixpkgs.hostPlatform = nixpkgs.lib.mkDefault "x86_64-linux";
            system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
          }

          home-manager.nixosModules.home-manager
          impermanence.nixosModules.impermanence
          lanzaboote.nixosModules.lanzaboote

          ./system
          ./users
          ./home
        ];
      };
      Rico2 = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = inputs;
        modules = [
          ./nix.nix

          {
            nixpkgs.hostPlatform = nixpkgs.lib.mkDefault "aarch64-linux";
            system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
          }

          nixos-hardware.nixosModules.raspberry-pi-4

          ./users
          ./system.rico
        ];
      };
    };
  };
}
