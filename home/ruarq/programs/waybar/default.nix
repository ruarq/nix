{ config, ... }:
let
  updateInterval = 5;
  hotbar-selected = "minecraft-hotbar-selected.png";
  hotbar = "minecraft-hotbar.png";
  button = "minecraft-button.png";
in {
  programs.waybar = {
    enable = true;
    settings = {
      default = {
        name = "default";
        layer = "top";
        position = "top";
        margin = "10 10 0 10";
        height = 20;
        modules-left = [
          "sway/workspaces"
        ];
        modules-right = [
          "network"
          "cpu"
          "temperature"
          "memory"
          "disk"
          "battery"
          "clock"
        ];
        cpu = {
          format = "C {usage}%";
          tooltip-format = "Load: {load:.0f}%";
          interval = updateInterval;
        };
        memory = {
          format = "M {avail}GiB";
          tooltip-format = "SWP: {swapAvail}GiB";
          interval = updateInterval;
        };
        disk = {
          format = "D {free}";
          interval = updateInterval;
        };
        network = {
          format = "N {signalStrength}%";
          tooltip-format = "Connected to: {essid} ({ipaddr})\nBandwidth: ↑{bandwidthUpBits} ↓{bandwidthDownBits}";
          interval = updateInterval;
        };
        battery = {
          format = "B {capacity}%";
          tooltip-format = "{power:.0f}W\n{time}";
          interval = updateInterval;
        };
        clock = {
          format = "{:%H:%M}";
          tooltip-format = "{:%a %d. %b}";
        };
      };
    };
    style = ''
      * {
        font-family: "Monocraft" /* , "FiraCode Nerd Font Mono" */;
        font-size: 12px;
        min-height: 0;
      }

      window#waybar {
          /* background-color: #1e1e2e; */
          background-color: transparent;
          color: #cdd6f4;
          transition-property: background-color;
          transition-duration: .5s;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      button {
          /* Use box-shadow instead of border so the text isn't offset */
          box-shadow: inset 0 -3px transparent;
          /* Avoid rounded borders under each button name */
          border: none;
          border-radius: 0;
      }

      #workspaces {
        background-image: url("${config.home.homeDirectory}/.${hotbar}");
        background-size: 180px 20px;
      }

      #workspaces button {
        padding: 0 2px;
        background-color: transparent;
        color: #cdd6f4;
      }

      #workspaces button.focused {
        /* background-color: #313244; */
        background-image: url("${config.home.homeDirectory}/.${hotbar-selected}");
        background-size: 22px 20px;
        background-position: center;
      }

      #workspaces button.urgent {
          background-color: #eb4d4b;
      }

      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        background-image: url("${config.home.homeDirectory}/.${hotbar-selected}");
        background-size: 22px 20px;
        background-position: center;
        padding: 0 2px;
      }

      #mode {
          background-color: #6c7086;
      }

      tooltip {
        color: #cdd6f4;
        background-color: #313244;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #network {
        padding: 0 10px;
        margin-left: 5px;
        margin-right: 5px;
        color: #cdd6f4;
        background-image: url("${config.home.homeDirectory}/.${button}");
        background-size: 100% 100%;
      }

      .modules-left > widget:first-child > * {
        margin-left: 0;
      }

      .modules-right > widget:last-child > * {
        margin-right: 0;
      }

      #battery.charging, #battery.plugged {
        color: #89b4fa;
      }

      #battery.critical {
        color: #f53c3c;
      }

      #temperature.critical {
        color: #f53c3c;
      }

      #network.disconnected {
        color: #f53c3c;
      }
    '';
  };

  home.file = {
    ".${hotbar-selected}" = {
      source = ../../assets/${hotbar-selected};
    };
    ".${hotbar}" = {
      source = ../../assets/${hotbar};
    };
    ".${button}" = {
      source = ../../assets/${button};
    };
  };
}
