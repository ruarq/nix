{ nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle, ... }: {
  imports = [
    nix-homebrew.darwinModules.nix-homebrew
    {
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

  homebrew = {
    enable = true;
    casks = [
      "amethyst"
      "djuced"
      "zen-browser"
      "tidal"
      "nextcloud"
      "arduino-ide"
      "anydesk"
    ];
  };
}
