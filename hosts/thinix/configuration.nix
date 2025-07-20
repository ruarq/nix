{ pkgs, ... }: {
  nix.settings.experimental-features = "nix-command flakes";

  imports = [
    # home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    ../../home/users.nix
  ];

  networking = {
    hostName = "thinix";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Berlin";

  environment.systemPackages = with pkgs; [
    wayland
    wayland-utils
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  console.keyMap = "de";

  services = {
    tlp.enable = true;
    xserver = {
      enable = true;
      xkb.layout = "de";
    };
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
      sessionPackages = with pkgs; [
        sway
      ];
      defaultSession = "sway";
    };
    dbus.enable = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  system.stateVersion = "25.05";
}
