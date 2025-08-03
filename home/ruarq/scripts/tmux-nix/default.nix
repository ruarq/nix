{ pkgs, ... }: {
  home.packages = with pkgs; [
    (writeScriptBin "tmux-nix" (builtins.readFile ./script.sh))
  ];
}
