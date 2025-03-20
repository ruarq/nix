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
    commonConfig = { pkgs, ... }: {
      nix.settings.experimental-features = "nix-command flakes";

      environment.systemPackages = with pkgs; [
        alacritty
        neovim
        tmux
        git
        zsh
        python3
        rustup
        signal-desktop
      ];

      fonts.packages = with pkgs; [
        nerd-fonts.fira-code
      ];

      nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
        "signal-desktop"
      ];

    };

    darwinConfig = { ... }: {
      homebrew = {
        enable = true;
        casks = [
          "amethyst"
          "djuced"
          "zen-browser"
          "tidal"
        ];
      };

      imports = [
        home-manager.darwinModules.home-manager
      ];

      users.users.ruarq = {
        name = "ruarq";
        home = "/Users/ruarq";
      };

      home-manager = {
        users = {
          ruarq = import ./users/ruarq/home.nix;
        };
      };

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      nixpkgs.hostPlatform = "aarch64-darwin";
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
        mac-app-util.darwinModules.default
        nix-homebrew.darwinModules.nix-homebrew {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "ruarq";
            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
              "homebrew/homebrew-bundle" = homebrew-bundle;
            };

            mutableTaps = false;
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
