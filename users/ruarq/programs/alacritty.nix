{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      terminal = {
        shell = {
          program = "${pkgs.tmux}/bin/tmux";
        };
      };

      font = {
        size = 14;

        normal = {
          family = "FiraCode Nerd Font Mono";
        };
      };
    };
  };
}
