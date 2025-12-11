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
        tags = [ "orf" "news" ];
        url = "https://www.tagesschau.de/infoservices/alle-meldungen-100~rss2.xml";
      }
      {
        title = "Rust Main Blog";
        tags = [ "cs" ];
        url = "https://blog.rust-lang.org/feed.xml";
      }
      {
        title = "NixOS Announcements";
        tags = [ "cs" ];
        url = "https://nixos.org/blog/announcements-rss.xml";
      }
      {
        title = "neovim news";
        tags = [ "cs" ];
        url = "https://neovim.io/news.xml";
      }
      {
        title = "Fabric MC";
        tags = [ "gaming" ];
        url = "https://fabricmc.net/feed.xml";
      }
      {
        title = "Hacker News";
        tags = [ "cs" "news" ];
        url = "https://hnrss.org/frontpage?points=100";
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
