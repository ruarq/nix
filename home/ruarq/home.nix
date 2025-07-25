{ pkgs, ... }: {
  home = {
    username = "ruarq";
    homeDirectory = "/home/ruarq";
    stateVersion = "25.05";
  };

  services.gnome-keyring.enable = true;

  home.packages = with pkgs; [
    delta
    tree
    htop
    fastfetch

    cloc
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
    nodejs
    bun
    rustup
    cargo-release
    cargo-semver-checks

    nerd-fonts.fira-code

    firefox
    thunderbird
    element-desktop gcr
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
  ];
}
