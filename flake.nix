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
      url = "github:adtya/lanzaboote/build_fix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:pta2002/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, impermanence, lanzaboote, nixvim }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
    in
    {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
      nixosConfigurations = {
        Skipper = lib.nixosSystem {
          specialArgs = inputs;
          modules = [
            ./nix.nix

            {
              nixpkgs.overlays = [ (import ./packages) hyprland.overlays.default ];
              system.configurationRevision = lib.mkIf (self ? rev) self.rev;
            }

            home-manager.nixosModules.home-manager
            hyprland.nixosModules.default
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
