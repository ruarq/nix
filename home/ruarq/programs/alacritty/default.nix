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
        size = 13;

        normal = {
          family = "Monocraft";
        };
      };
    };
  };
}
