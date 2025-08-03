{ pkgs, ... }: {
  home = {
    username = "ruarq";
    homeDirectory = "/home/ruarq";
    stateVersion = "25.05";
  };

  home.packages = with pkgs; [
    delta
    tree
    htop
    fastfetch
    unzip

    cloc
    gnumake
    ninja
    openssh
    keychain
    wl-clipboard
    pw-volume
    brightnessctl

    isabelle
    clang_20
    python3
    python3Packages.pip
    go
    nodejs_24
    bun
    rustup
    cargo-release
    cargo-semver-checks

    nerd-fonts.fira-code

    firefox
    thunderbird
    element-desktop gcr
    bitwig-studio5
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
    ./programs/waybar/default.nix

    ./scripts/tmux-nix/default.nix
    ./scripts/tmux-proofbuddy/default.nix
  ];
}
