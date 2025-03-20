{ pkgs, ... }:
{
  nix.settings.experimental-features = "nix-command flakes";

  environment.systemPackages = with pkgs; [
    # programming tools
    neovim
    tmux
    git
    zsh
    python3
    rustup
    delta

    # can't move these to /users/ruarq/home.nix (for new) as that
    # breaks the mac-app-util flake
    signal-desktop
    alacritty
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];
  
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "signal-desktop"
  ];
}
