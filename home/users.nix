{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    vendor = {
      functions.enable = true;
      config.enable = true;
      completions.enable = true;
    };
  };

  users.users.ruarq = {
    isNormalUser = true;
    description = "ruarq";
    home = "/home/ruarq";
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "input"
      "realtime"
      "pipewire"
    ];
  };

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      ruarq = import ./ruarq/home.nix;
    };
  };
}
