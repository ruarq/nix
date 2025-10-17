{ pkgs, ... }:
{
  home = {
    username = "ruarq";
    homeDirectory = "/home/ruarq";
    stateVersion = "25.05";
  };

  home.packages = with pkgs; [
    # cli programs
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
    file
    direnv

    # language stuff
    isabelle
    clang_20
    llvmPackages_20.clang-tools
    python3
    python3Packages.pip
    go
    nodejs_24
    bun
    rustup
    cargo-release
    cargo-semver-checks
    cargo-tarpaulin

    # Fonts
    nerd-fonts.fira-code
    monocraft

    # GUI programs
    firefox
    discord
    thunderbird
    element-desktop gcr
    steam
    prismlauncher
    tidal-hifi
    anydesk
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
