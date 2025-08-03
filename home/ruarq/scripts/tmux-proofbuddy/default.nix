{ pkgs, ... }: {
  home.packages = with pkgs; [
    (writeScriptBin "tmux-proofbuddy" (builtins.readFile ./script.sh))
  ];
}
