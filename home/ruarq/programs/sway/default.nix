{ pkgs, ... }: let mod = "Mod4"; in {
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = {
      modifier = mod;
      terminal = "alacritty";
      input = {
        "*" = {
          xkb_layout = "de";
        };
      };
      defaultWorkspace = "${mod}+1";
      # bars = [
      #   { command = "waybar"; }
      # ];
    };
  };
}
