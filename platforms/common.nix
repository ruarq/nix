{ pkgs, ... }: {
  nix.settings.experimental-features = "nix-command flakes";

  environment.systemPackages = with pkgs; [
    neovim
    tmux
    git
    zsh
    python3
    rustup
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];
}
