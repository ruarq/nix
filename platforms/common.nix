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
    rustup
    delta
    bandsnatch.packages.${pkgs.system}.default
    git
    openssh

    # can't move these to /users/ruarq/home.nix (for now) as that
    # breaks the mac-app-util flake
    signal-desktop
    alacritty
    ];

    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
    ];

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
      "signal-desktop"
    ];
  }
