{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence/master";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    impermanence,
    lanzaboote,
  } @ inputs: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
  in {
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
    nixosConfigurations = {
      Skipper = lib.nixosSystem {
        specialArgs = inputs;
        modules = [
          ./system/nix.nix

          {
            nixpkgs.overlays = [(import ./packages)];
            system.configurationRevision = lib.mkIf (self ? rev) self.rev;
          }

          home-manager.nixosModules.home-manager
          impermanence.nixosModules.impermanence
          lanzaboote.nixosModules.lanzaboote

          ./system
          ./users
          ./home
        ];
      };
    };
  };
}
