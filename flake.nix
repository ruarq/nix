{
  description = "Zenful nix-darwin system flake";

  inputs = {
    # nixpkgs & nix-darwin
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # show applications installed through nix in spotlight
    mac-app-util.url = "github:hraban/mac-app-util";

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };

    # wsl
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,

    # darwin
    nix-darwin,
    mac-app-util,
    nix-homebrew,
    homebrew-core,
    homebrew-cask,
    homebrew-bundle,

    # wsl
    nixos-wsl,
    ...
  }:
  let
    commonConfig = import ./platforms/common.nix;
    
    darwinConfig = import ./platforms/darwin.nix {
      inherit home-manager mac-app-util nix-homebrew homebrew-core homebrew-cask homebrew-bundle;
    };
    
    wslConfig = { pkgs, ... }: {
      imports = [
        home-manager.nixosModules.home-manager
      ];

      # root fs for wsl
      fileSystems."/" = {
        device = "none";
        fsType = "tmpfs";
        options = [ "defaults" ];
      };

      # disable bootloader
      boot.loader.grub.enable = false;

      programs.zsh.enable = true;

      users.users.ruarq = {
        isNormalUser = true;
        name = "ruarq";
        home = "/home/ruarq";
        extraGroups = [ "wheel" "networkmanager" ];
        shell = pkgs.zsh;
      };

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        users = {
          ruarq = import ./users/ruarq/home.nix;
        };
      };

      system.stateVersion = "25.05";
    };
  in
  {
    darwinConfigurations."darwin" = nix-darwin.lib.darwinSystem {
      modules = [
        commonConfig
        darwinConfig
        {
          system = {
            configurationRevision = self.rev or self.dirtyRev or null;
          };
        }
      ];
    };

    nixosConfigurations."wsl" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        commonConfig
        wslConfig
        nixos-wsl.nixosModules.default {
          wsl = {
            enable = true;
            defaultUser = "ruarq";
          };
        }
      ];
    };
  };
}
