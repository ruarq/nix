{ ... }: let updateInterval = 5; in {
  programs.waybar = {
    enable = true;
    settings = {
      default = {
        name = "default";
        layer = "top";
        position = "bottom";
        height = 20;
        modules-left = [
          "sway/workspaces"
        ];
        modules-right = [
          "cpu"
          "memory"
          "disk"
          "network"
          "battery"
          "clock"
        ];
        cpu = {
          format = "CPU {load}% {avg_frequency}GHz";
          interval = updateInterval;
        };
        memory = {
          format = "RAM {avail}GiB";
          interval = updateInterval;
        };
        disk = {
          format = "DSK {free}";
          interval = updateInterval;
        };
        network = {
          format = "{ipaddr} ↑{bandwidthUpBits} ↓{bandwidthDownBits}";
          tooltip-format = "{essid}";
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
        font-size: 12px;
        min-height: 0;
      }
    '';
  };
}
