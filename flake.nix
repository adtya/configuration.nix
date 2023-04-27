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

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:pta2002/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, impermanence, lanzaboote, nixos-hardware, nixvim }@inputs: {
    formatter."x86_64-linux" = nixpkgs.legacyPackages."x86_64-linux".nixpkgs-fmt;
    nixosConfigurations = {
      Skipper = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [
          {
            nixpkgs.overlays = [ (import ./packages) ];
            nixpkgs.hostPlatform = nixpkgs.lib.mkDefault "x86_64-linux";
            system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
          }

          home-manager.nixosModules.home-manager
          impermanence.nixosModules.impermanence
          lanzaboote.nixosModules.lanzaboote

          ./common
          ./hosts/skipper
          ./home
        ];
      };
      Rico2 = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = inputs;
        modules = [
          {
            nixpkgs.hostPlatform = nixpkgs.lib.mkDefault "aarch64-linux";
            system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
          }

          ./common
          ./hosts/rico
        ];
      };
    };
  };
}
