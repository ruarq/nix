{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
    clock24 = true;
    historyLimit = 10000;
    mouse = true;
    baseIndex = 1;
    shell = "${pkgs.zsh}/bin/zsh";
    prefix = "C-Space"; # deactivate "Select the previous input source" and "Select next source in Input menu" under "Settings > Keyboard > Keyboard Shortcuts > Input Sources" when on MacOS
    sensibleOnTop = false;
    escapeTime = 0; # to avoid delays with esc in nvim

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      {
        plugin = catppuccin;
        extraConfig = ''
        set -g @catppuccin_flavour 'mocha'
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
