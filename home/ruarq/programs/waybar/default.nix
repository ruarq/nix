{ ... }: let updateInterval = 5; in {
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
          format = "CPU {usage}% / {load:.0f}%";
          interval = updateInterval;
        };
        memory = {
          format = "RAM {avail}GiB SWP {swapAvail}GiB";
          interval = updateInterval;
        };
        disk = {
          format = "DSK {free}";
          interval = updateInterval;
        };
        network = {
          format = "↑{bandwidthUpBits} ↓{bandwidthDownBits} ({signalStrength}%)";
          tooltip-format = "Connected to: {essid} ({ipaddr})";
          interval = updateInterval;
        };
        battery = {
          format = "{capacity}% ({power:.0f}W) {time}";
          interval = updateInterval;
        };
        clock = {
          format = "{:%a, %d. %b  %H:%M}";
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

      #workspaces button {
        padding: 0 5px;
        margin-left: 5px;
        margin-right: 5px;
        background-color: transparent;
        color: #cdd6f4;
      }

      #workspaces button.focused {
          background-color: #313244;
      }

      #workspaces button.urgent {
          background-color: #eb4d4b;
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
      }

      .modules-left > widget:first-child > * {
        margin-left: 0;
      }

      .modules-right > widget:last-child > * {
        margin-right: 0;
      }

      #clock {
        background-color: #313244;
      }

      #battery {
        background-color: #45475a;
      }

      #battery.charging, #battery.plugged {
        background-color: #26A65B;
      }

      #battery.critical {
        background-color: #f53c3c;
      }

      label:focus {
        background-color: #6c7086;
      }

      #cpu, #temperature {
        background-color: #45475a;
      }

      #temperature.critical {
        background-color: #f53c3c;
      }

      #memory, #disk {
        background-color: #313244;
      }

      #network {
        background-color: #313244;
      }

      #network.disconnected {
        background-color: #f53c3c;
      }
    '';
  };
}
