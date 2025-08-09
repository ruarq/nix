{ pkgs, ... }: {
  home.packages = with pkgs; [
    (writeScriptBin "tmux-iris" (builtins.readFile ./script.sh))
  ];
}
