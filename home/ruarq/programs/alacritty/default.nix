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
        size = 12;

        normal = {
          family = "FiraCode Nerd Font Mono";
        };
      };
    };
  };
}
