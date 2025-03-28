{ bandsnatch, ... }: { pkgs, ... }:
{
  nix.settings.experimental-features = "nix-command flakes";

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    # programming tools
    neovim
    tmux
    zsh
    python3
    delta
    git
    openssh
    clang_19

    # rust
    rustup
    cargo-release
    cargo-semver-checks
    cargo-espflash
    cargo-espmonitor
    esp-generate

    # cli apps
    bandsnatch.packages.${pkgs.system}.default
    tidal-dl

    # can't move these to /users/ruarq/home.nix (for now) as that
    # breaks the mac-app-util flake
    signal-desktop
    alacritty
    bitwarden-desktop
    obsidian
    ];

    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
    ];

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
      "signal-desktop"
      "obsidian"
    ];
  }
