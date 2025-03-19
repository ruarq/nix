{ pkgs, ... }:
{
  imports = [
    ./programs/zsh.nix
    ./programs/neovim.nix
    ./programs/tmux.nix
    ./programs/alacritty.nix
    ./programs/git.nix
  ];

  home = {
    username = "ruarq";
    homeDirectory =
      if pkgs.stdenv.isDarwin
      then "/Users/ruarq"
      else "/home/ruarq";
    stateVersion = "25.05";
  };
}
