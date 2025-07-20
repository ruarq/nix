{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "ruarq";
    userEmail = "anton@ruarq.co";

    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJtB3gatR2o6kdlYlYVtWIqX+xxSCpSE3mmbcw+o6pFt";
      signByDefault = true;
      signer = "ssh";
    };

    extraConfig = {
      init.defaultBranch = "main";

      core = {
        editor = "nvim";
        pager = "${pkgs.delta}/bin/delta";
      };

      pull.rebase = true;
      push.autoSetupRemote = true;

      diff.colorMoved = "default";
      merge.conflictStyle = "diff3";
      gpg.format = "ssh";
    };

    ignores = [
      ".DS_Store"
      "*.swp"
      ".direnv/"
      ".envrc"
    ];
  };
}
