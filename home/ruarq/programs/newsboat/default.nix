{ lib, pkgs, ... }:
let
  catppuccin = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/newsboat/refs/heads/main/themes/dark";
    hash = "sha256-KZ3PQkgF5Q8deYfVsbFBfPQvihwHKZPR/qjRSs4DpSc=";
  };
in
{
  programs.newsboat = {
    enable = true;
    autoReload = true;
    # autoFetchArticles.enable = "automatic";

    urls = [
      {
        title = "tagesschau";
        tags = [ "orf" ];
        url = "https://www.tagesschau.de/infoservices/alle-meldungen-100~rss2.xml";
      }
      {
        title = "Rust Blog [main]";
        tags = [ "lang" ];
        url = "https://blog.rust-lang.org/feed.xml";
      }
    ];

    extraConfig = ''
      unbind-key ENTER
      unbind-key j
      unbind-key k
      unbind-key J
      unbind-key K

      bind-key j down
      bind-key k up
      bind-key l open
      bind-key h quit

      ${lib.readFile catppuccin}
    '';
  };
}
