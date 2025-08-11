{ pkgs, ... }: {
  home.packages = with pkgs; [
    (writeScriptBin "tedit" (builtins.readFile ./script.sh))
  ];
}
