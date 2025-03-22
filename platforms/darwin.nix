{ home-manager, mac-app-util, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle }: { ... }: {
  imports = [
    home-manager.darwinModules.home-manager
    mac-app-util.darwinModules.default
    (import ../users/ruarq/darwin/homebrew.nix {
      inherit nix-homebrew homebrew-core homebrew-cask homebrew-bundle;
    })
  ];

  users.users.ruarq = {
    name = "ruarq";
    home = "/Users/ruarq";
  };

  home-manager = {
    users = {
      ruarq = import ../users/ruarq/home.nix;
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  nixpkgs.hostPlatform = "aarch64-darwin";
}
