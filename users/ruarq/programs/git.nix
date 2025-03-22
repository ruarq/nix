{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "ruarq";
    userEmail = "anton@ruarq.co";

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

      credential.helper = "libsecret";
    };

    ignores = [
      ".DS_Store"
      "*.swp"
      ".direnv/"
      ".envrc"
    ];
  };
}
