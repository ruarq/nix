{ ... }: {
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = {
      modifier = "Mod4";
      terminal = "alacritty";
      input = {
        "*" = {
          xkb_layout = "de";
        };
      };
      # bars = [
      #   { command = "waybar"; }
      # ];
    };
  };
}
