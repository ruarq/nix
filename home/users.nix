{ pkgs, ... }: {
  programs.zsh.enable = true;

  users.users.ruarq = {
    isNormalUser = true;
    description = "ruarq";
    home = "/home/ruarq";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "input"
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
