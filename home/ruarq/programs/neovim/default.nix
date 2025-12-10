{ lib, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      nixd
      ripgrep
      fd
      rust-analyzer
      rustfmt
      gopls
      typescript-language-server
      prettierd
      jdt-language-server
      tinymist
      typst-fmt
      pyright
    ];

    plugins = with pkgs.vimPlugins; [
      vim-prettier
      typst-vim
      git-blame-nvim
      oil-nvim
      nvim-colorizer-lua
      nvim-jdtls

      # language server
      vim-nix
      nvim-lspconfig

      # fuzzy finder
      plenary-nvim
      telescope-nvim

      # syntax-highlighting
      rust-vim
      {
        plugin = nvim-treesitter.withPlugins (plugins: [
          plugins.rust
          plugins.nix
          plugins.lua
          plugins.bash
          plugins.vim
          plugins.python
          plugins.java
        ]);
      }
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      catppuccin-nvim
    ];

    extraLuaConfig = ''
      ${lib.readFile ./init.lua}
    '';
  };
}

