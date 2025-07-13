# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ home-manager, ... }:
{ pkgs, ... }:
{
  imports =
    [
      home-manager.nixosModules.home-manager
      ./linux-hardware.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "/dev/nvme0n1";

  networking.hostName = "thinix";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  services.xserver.enable = true;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.xkb.layout = "de";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  services.libinput.enable = true;

  environment.systemPackages = with pkgs; [
    firefox
    pulseaudio
  ];

  users.users.ruarq = {
     isNormalUser = true;
     description = "ruarq";
     shell = pkgs.zsh;
     home = "/home/ruarq";
     extraGroups = [ "wheel" "networkmanager" ];
     packages = with pkgs; [
       tree
     ];
   };

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      ruarq = import ../users/ruarq/home.nix;
    };
  };

  system.stateVersion = "25.05";

}

