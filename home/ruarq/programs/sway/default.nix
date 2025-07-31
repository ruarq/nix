{ config, ... }: {
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    checkConfig = false; # enabling this will create issues with the wallpapers
    config = {
      input."*" = {
        xkb_layout = "de";
      };
      modifier = "Mod4";
      terminal = "alacritty";
      bars = [
        {
          command = "waybar";
        }
      ];
      gaps = {
        inner = 5;
        outer = 5;
        smartBorders = "on";
        smartGaps = true;
      };
      window.titlebar = false;
      output = {
        "*" = {
          bg = "${config.home.homeDirectory}/.wallpaper.jpg fill";
        };

        eDP-1 = {
          pos = "0,1200";
        };

        HDMI-A-2 = {
          pos = "0,0";
        };
      };
    };
    extraConfig = ''
      bindsym XF86AudioRaiseVolume exec pw-volume change +5%
      bindsym XF86AudioLowerVolume exec pw-volume change -5%
      bindsym XF86AudioMute exec pw-volume mute toggle

      bindsym XF86MonBrightnessUp exec brightnessctl set +5%
      bindsym XF86MonBrightnessDown exec brightnessctl set 5%-
    '';
  };

  home.file.".wallpaper.jpg" = {
    source = ../../assets/wallpaper.jpg;
  };
}
