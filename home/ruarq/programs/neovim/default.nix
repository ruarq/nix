{ lib, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      vim-prettier
      typst-vim
      git-blame-nvim
      oil-nvim
      nvim-colorizer-lua
      nvim-jdtls
      vim-nix
      nvim-lspconfig
      plenary-nvim
      telescope-nvim
      rust-vim

      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path

      catppuccin-nvim
      (nvim-treesitter.withPlugins (plugins: [
        plugins.rust
        plugins.nix
        plugins.lua
        plugins.bash
        plugins.vim
        plugins.python
        plugins.java
        plugins.go
      ]))
    ];

    extraLuaConfig = ''
      ${lib.readFile ./init.lua}
      ${lib.readFile ./lspconfig.lua}
      ${lib.readFile ./keymap.lua}
      ${lib.readFile ./virtual_text_prefix_animation.lua}
      ${lib.readFile ./theme.lua}
      ${lib.readFile ./format_on_save.lua}
    '';
  };
}

