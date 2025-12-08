{ pkgs, ... }: {
  home.packages = with pkgs; [
    (writeScriptBin "minecraft" ''
      #/usr/bin/env sh
      exec "${pkgs.lunar-client}/bin/lunar-client"
    '')
  ];
}
