{ config, pkgs, ... }: {
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    clock24 = true;
    historyLimit = 10000;
    mouse = true;
    baseIndex = 1;
    shell = "${pkgs.fish}/bin/fish";
    prefix = "C-Space"; # deactivate "Select the previous input source" and "Select next source in Input menu" under "Settings > Keyboard > Keyboard Shortcuts > Input Sources" when on MacOS
    sensibleOnTop = false;
    escapeTime = 0; # to avoid delays with esc in nvim

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      {
        plugin = catppuccin;
        extraConfig = ''
        set -g @catppuccin_flavour 'mocha'
        set -g status-right-length 100
        set -g status-left-length 100
        set -g status-left ""
        set -g status-right "#{E:@catppuccin_status_application}"
        set -agF status-right "#{E:@catppuccin_status_cpu}"
        set -ag status-right "#{E:@catppuccin_status_session}"
        set -ag status-right "#{E:@catppuccin_status_uptime}"
        set -agF status-right "#{E:@catppuccin_status_battery}"

        run ${config.home.homeDirectory}/.config/tmux/plugins/tmux-plugins/tmux-cpu/cpu.tmux
        run ${config.home.homeDirectory}/.config/tmux/plugins/tmux-plugins/tmux-battery/battery.tmux
        '';
      }
      yank
    ];

    extraConfig = ''
    # split windows
    bind '"' split-window -v -c "#{pane_current_path}"
    bind % split-window -h -c "#{pane_current_path}"
    '';

  };
}

