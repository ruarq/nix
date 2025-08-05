{
  description = "nix flake for my work laptop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # catppuccin.url = "github:catppuccin/nix";
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  }: {
    nixosConfigurations.thinix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        (import ./configuration.nix)
        home-manager.nixosModules.home-manager
      ];
    };
  };
}
