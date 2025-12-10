{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    vendor = {
      functions.enable = true;
      config.enable = true;
      completions.enable = true;
    };
  };

  documentation = {
    enable = true;
    dev.enable = true;
    man = {
      enable = true;
      man-db.enable = true;
      mandoc.enable = false;
      generateCaches = true;
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
      "pipewire"
      "wireshark"
      "docker"
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
