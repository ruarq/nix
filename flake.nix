<<<<<<< HEAD
{
  description = "Zenful nix-darwin system flake";

  inputs = {
    # nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # show applications installed through nix in spotlight
    mac-app-util.url = "github:hraban/mac-app-util";

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

    # bandsnatch (bandcamp bulk downloader)
    bandsnatch.url = "github:ovyerus/bandsnatch";
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

    # other stuff
    bandsnatch,
    ...
  }:
  let
    commonConfig = import ./platforms/common.nix {
      inherit bandsnatch;
    };
    
    darwinConfig = import ./platforms/darwin.nix {
      inherit home-manager mac-app-util nix-homebrew homebrew-core homebrew-cask homebrew-bundle;
    };
    
    wslConfig = import ./platforms/wsl.nix {
      inherit home-manager;
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
||||||| (empty tree)
=======
{
  description = "Zenful nix-darwin system flake";

  inputs = {
    # nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # show applications installed through nix in spotlight
    mac-app-util.url = "github:hraban/mac-app-util";

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

    # bandsnatch (bandcamp bulk downloader)
    bandsnatch.url = "github:ovyerus/bandsnatch";
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

    # other stuff
    bandsnatch,
    ...
  }:
  let
    commonConfig = import ./platforms/common.nix {
      inherit bandsnatch;
    };

    linuxConfig = import ./platforms/linux.nix {
      inherit home-manager;
    };
    
    darwinConfig = import ./platforms/darwin.nix {
      inherit home-manager mac-app-util nix-homebrew homebrew-core homebrew-cask homebrew-bundle;
    };
    
    wslConfig = import ./platforms/wsl.nix {
      inherit home-manager;
    };
  in
  {
    nixosConfigurations."thinix" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        commonConfig
	linuxConfig
      ];
    };

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
>>>>>>> 1d859a3 (linux system)
