{ ... }:
{
  imports = [
    ./programs/zsh.nix
    ./programs/neovim.nix
    ./programs/tmux.nix
    ./programs/alacritty.nix
    ./programs/git.nix
  ];

  home.username = "ruarq";
  home.homeDirectory = "/Users/ruarq";
  home.stateVersion = "25.05";
}
