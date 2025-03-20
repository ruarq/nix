{ pkgs, ... }: {
  nix.settings.experimental-features = "nix-command flakes";

  environment.systemPackages = with pkgs; [
    alacritty
    neovim
    tmux
    git
    zsh
    python3
    rustup
    signal-desktop
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "signal-desktop"
  ];
}
