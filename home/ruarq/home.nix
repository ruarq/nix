{ pkgs, ... }:
{
  home = {
    username = "ruarq";
    homeDirectory = "/home/ruarq";
    stateVersion = "25.05";
  };

  home.packages = with pkgs; [
    delta
    tree
    htop
    neofetch
    unzip
    watson
    license-generator
    cloc
    gnumake
    ninja
    openssh
    keychain
    wl-clipboard
    pw-volume
    brightnessctl
    pavucontrol

    # for audio production
    winetricks
    wineWowPackages.yabridge
    yabridge
    yabridgectl

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
    cargo-tarpaulin

    nerd-fonts.fira-code
    monocraft

    firefox
    discord
    thunderbird
    element-desktop gcr
    bitwig-studio5
    steam
    prismlauncher
  ];

  imports = [
    ./programs/fish/default.nix
    ./programs/tmux/default.nix
    ./programs/git/default.nix
    ./programs/neovim/default.nix
    ./programs/sway/default.nix
    ./programs/alacritty/default.nix
    ./programs/ssh/default.nix
    ./programs/waybar/default.nix

    ./scripts/tedit/default.nix
    ./scripts/nixcfg/default.nix
    ./scripts/tmux-proofbuddy/default.nix
    ./scripts/tmux-iris/default.nix
    ./scripts/minecraft/default.nix
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    XDG_PICTURES_DIR="$HOME/Pictures";
    XDG_SCREENSHOTS_DIR="$HOME/Pictures/Screenshots";
  };
}
