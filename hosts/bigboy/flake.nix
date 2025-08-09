{
  description = "nix flake for my home desktop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    musnix  = { url = "github:musnix/musnix"; };
    # catppuccin.url = "github:catppuccin/nix";
  };

  outputs = {
    nixpkgs,
    home-manager,
    musnix,
    ...
  }: {
    nixosConfigurations.bigboy = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        (import ./configuration.nix)
        musnix.nixosModules.musnix
        home-manager.nixosModules.home-manager
      ];
    };
  };
}
