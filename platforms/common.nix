{ bandsnatch, ... }: { pkgs, ... }:
{
  nix.settings.experimental-features = "nix-command flakes";

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    # programming tools
    neovim
    tmux
    zsh
    delta
    git
    openssh
    gh
    ripgrep
    cloc

    # Isabelle
    isabelle

    # C / C++
    clang_19

    # python
    python3
    python3Packages.pip

    # go
    go
    gopls

    # web development
    nodejs_20
    typescript-language-server
    nodePackages.prettier
    prettierd

    # rust
    rustup
    cargo-release
    cargo-semver-checks

    # cli apps
    bandsnatch.packages.${pkgs.system}.default
    tidal-dl

    # breaks the mac-app-util flake
    signal-desktop
    alacritty
    bitwarden-desktop
    obsidian

    # element-desktop
    (if !stdenv.isDarwin then element-desktop else null)
    ];

    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
    ];

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
      "signal-desktop"
      "obsidian"
    ];
  }
