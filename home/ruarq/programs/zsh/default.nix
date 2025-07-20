{ ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "eastwood";
    };

    initContent = ''
    eval $(ssh-agent -s)
    ssh-add ~/.ssh/id_ed25519
    clear
    '';
  };
}
