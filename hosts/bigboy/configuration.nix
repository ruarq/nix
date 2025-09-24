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

    kdePackages.sddm-kcm
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  console.keyMap = "de";

  services = {
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
        (writeTextFile {
          name = "sway-unsupported-gpu";
          destination = "/share/wayland-sessions/sway-unsupported-gpu.desktop";
          text = ''
            [Desktop Entry]
            Name=Sway (--unsupported-gpu)
            Comment=An i3-compatible Wayland compositor with GPU support
            Exec=sway --unsupported-gpu
            Type=Application
          '';
          passthru.providedSessions = ["sway-unsupported-gpu"];
        })
      ];
      defaultSession = "sway-unsupported-gpu";
    };

    desktopManager.plasma6.enable = true;

    dbus.enable = true;

    gnome.gnome-keyring.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
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

  musnix = {
    enable = true;
    # kernel.realtime = true;
    das_watchdog.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
