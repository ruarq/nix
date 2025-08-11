{ pkgs, ... }: {
  home.packages = with pkgs; [
    (writeScriptBin "minecraft" ''
      #/usr/bin/env sh
      exec "${pkgs.prismlauncher}/bin/prismlauncher"
    '')
  ];
}
