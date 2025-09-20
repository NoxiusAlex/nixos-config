{
  description = "NixOS configuration with Hyprland";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    aniparser.url = "github:sinedka/aniparser-flake";
    aniparser.inputs.nixpkgs.follows = "nixpkgs";

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
      aniparser = inputs.aniparser.packages.${system}.default;
      caelestia-cli = inputs.caelestia-cli.packages.${system}.with-shell;
      zen-browser = inputs.zen-browser.packages."${system}".specific;
      user = "noxiusalex";
      hostname = "nixosuser";
      stateVersion = "25.05";
    in
    {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs stateVersion hostname user unstable; };

        modules = [
          ./hosts/${hostname}/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user}.imports = [ ./home-manager/home.nix inputs.zen-browser.homeModules.beta ];

            # home-manager.users.${user} = ./home-manager/home.nix;
            home-manager.extraSpecialArgs = { inherit inputs stateVersion user unstable aniparser caelestia-cli; };
          }
        ];
      };
    };
}
