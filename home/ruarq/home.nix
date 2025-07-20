{ pkgs, ... }: {
  home = {
    username = "ruarq";
    homeDirectory = "/home/ruarq";
    stateVersion = "25.05";
  };

  home.packages = with pkgs; [
    delta

    cloc
    openssh
    keychain

    wl-clipboard

    isabelle
    clang_20
    python3
    python3Packages.pip
    go
    nodejs
    bun
    rustup
    cargo-release
    cargo-semver-checks
    tree

    nerd-fonts.fira-code

    firefox
  ];

  imports = [
    # ./programs/zsh/default.nix
    ./programs/fish/default.nix
    ./programs/tmux/default.nix
    ./programs/git/default.nix
    ./programs/neovim/default.nix
    # ./programs/delta/default.nix
    ./programs/sway/default.nix
    ./programs/alacritty/default.nix
    ./programs/ssh/default.nix
  ];
}
