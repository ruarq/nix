{ pkgs, ... }: {
  programs.alacritty = {
    enable = true;
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
