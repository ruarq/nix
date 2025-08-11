{ pkgs, ... }: {
  home.packages = with pkgs; [
    (writeScriptBin "nixcfg" (builtins.readFile ./script.sh))
  ];
}
