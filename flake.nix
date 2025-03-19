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
  };

  outputs = {
    self,
    nix-darwin,
    mac-app-util,
    home-manager,
    nix-homebrew,
    homebrew-core,
    homebrew-cask,
    homebrew-bundle,
    ...
  }:
  let
    configuration = { pkgs, ... }: {
      # system packages
      environment.systemPackages = with pkgs; [
	      alacritty
	      neovim
	      tmux
	      git
        zsh
	      oh-my-zsh
	      python3
        rustup
        signal-desktop
      ];

      # homebrew packages
      homebrew = {
        enable = true;
        casks = [
          "amethyst"
          "djuced"
          "zen-browser"
          "tidal"
        ];
        brews = [
          "libiconv"
        ];
      };

      # allow unfree packages
      nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
       "signal-desktop"
      ];

      fonts.packages = with pkgs; [
        nerd-fonts.fira-code
      ];

      imports = [
        home-manager.darwinModules.home-manager
      ];

      users.users.ruarq = {
        name = "ruarq";
	      home = "/Users/ruarq";
      };

      home-manager.users.ruarq = import ./users/ruarq/home.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    darwinConfigurations."ruarqs-air" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
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
  };
}
