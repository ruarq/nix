{ pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    theme = "catppuccin_mocha";
    settings = {
      terminal = {
        shell = {
          program = "${pkgs.fish}/bin/fish";
        };
      };

      font = {
        size = 14;

        normal = {
          family = "Monocraft Nerd Font";
        };
      };
    };
  };
}
