{ config, pkgs, ... }:
let
  wallpaper = "minecraft-dark.wallpaper.png";
in {
  home.packages = with pkgs; [
    autotiling
    sway-contrib.grimshot
    rofi-wayland
    swaylock
  ];

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
      menu = "${pkgs.rofi-wayland}/bin/rofi -show drun";
      bars = [
        {
          command = "waybar";
        }
      ];
      gaps = {
        inner = 5;
        # outer = 5;
        top = 0;
        right = 5;
        bottom = 5;
        left = 5;
        smartBorders = "on";
      };
      window.titlebar = false;
      output = {
        "*" = {
          bg = "${config.home.homeDirectory}/.${wallpaper} fill";
        };

        eDP-1 = {
          pos = "0,0";
        };

        HDMI-A-2 = {
          pos = "0,-1200";
        };

        DP-3 = {
          mode = "1920x1080@144Hz";
        };
      };
    };
    extraConfig = ''
      bindsym XF86AudioRaiseVolume exec pw-volume change +5%
      bindsym XF86AudioLowerVolume exec pw-volume change -5%
      bindsym XF86AudioMute exec pw-volume mute toggle

      bindsym XF86MonBrightnessUp exec brightnessctl set +5%
      bindsym XF86MonBrightnessDown exec brightnessctl set 5%-

      bindsym Mod4+p exec grimshot save output
      bindsym Mod4+Shift+p exec grimshot save area

      output * adaptive_sync off

      workspace 4 output eDP-1
      exec swaymsg "workspace 4; exec thunderbird"

      workspace 3 output eDP-1
      assign [class="Element"] workspace 3
      exec swaymsg "exec element-desktop"

      workspace 2 output eDP-1
      exec swaymsg "workspace 2; exec firefox"

      workspace 1 output HDMI-A-2
      exec swaymsg "workspace 1; exec alacritty"

      exec_always autotiling
    '';
  };

  home.file.".${wallpaper}" = {
    source = ../../assets/${wallpaper};
  };
}
