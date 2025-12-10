{ ... }: {
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
    ];
  };
}
