{ pkgs, ... }: {
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
      eval (ssh-agent -c)
      ssh-add
      clear
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
