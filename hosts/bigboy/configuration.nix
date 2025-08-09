{ pkgs, ... }: {
  nix.settings.experimental-features = "nix-command flakes";

  imports = [
    ./hardware-configuration.nix
    ../../home/users.nix
  ];

  networking = {
    hostName = "bigboy";
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
      videoDrivers = ["nvidia"];
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

    gnome.gnome-keyring.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;

    # to unlock the keyring automatically
    pam.services = {
      sddm.enableGnomeKeyring = true;
      login.enableGnomeKeyring = true;
      passwd.enableGnomeKeyring = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
