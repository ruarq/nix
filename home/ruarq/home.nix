{ pkgs, ... }:
{
  home = {
    username = "ruarq";
    homeDirectory = "/home/ruarq";
    stateVersion = "25.11";
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
    ripgrep
    fd
    man-pages
    man-pages-posix
    newsboat

    # Programming language stuff
    isabelle
    clang_20
    llvmPackages_20.clang-tools
    python3
    python3Packages.pip
    pyright
    go
    gopls
    nodejs_24
    typescript-language-server
    prettierd
    rustc
    clippy
    cargo
    rust-analyzer
    rustfmt
    cargo-release
    cargo-semver-checks
    cargo-tarpaulin
    cargo-cross
    typst
    tinymist
    typst-fmt
    nixd
    nixfmt-rfc-style
    jdt-language-server
    lua-language-server
    stylua

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
    zathura
    arduino-ide
    wireshark
    realvnc-vnc-viewer
    nautilus
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
