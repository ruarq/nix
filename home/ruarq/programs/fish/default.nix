{ pkgs, ... }: {
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
    '';

    plugins = with pkgs.fishPlugins; [
      # {
      #   name = "plugin-git";
      #   src = pkgs.fishPlugins.plugin-git;
      # }
      {
        name = "hydro";
        src = hydro.src;
      }
    ];
  };
}
