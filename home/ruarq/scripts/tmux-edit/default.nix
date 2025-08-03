{ pkgs, ... }: {
  home.packages = with pkgs; [
    (writeScriptBin "tmux-edit" (builtins.readFile ./script.sh))
  ];
}
