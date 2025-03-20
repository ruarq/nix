{ ... }:
{
  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "eastwood";
    };

    # plugins = with pkgs; [ zsh-syntax-highlighting zsh-autosuggestions ];
  };
}
