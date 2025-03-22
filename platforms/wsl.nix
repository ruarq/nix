{ home-manager, ... }: { pkgs, ... }: {
  imports = [
    home-manager.nixosModules.home-manager
  ];

  environment.systemPackages = with pkgs; [
    gnome-keyring
  ];

  services.gnome.gnome-keyring.enable = true;

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
      ruarq = import ../users/ruarq/home.nix;
    };
  };

  system.stateVersion = "25.05";
}
