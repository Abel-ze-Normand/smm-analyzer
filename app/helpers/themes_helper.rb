module ThemesHelper
  def print_theme_stats(theme_stats)
    "MEAN LIKES: #{theme_stats[:mean_likes]}<br/>" +
      "VAR LIKES: #{theme_stats[:var_likes]}<br/>" +
      "MEAN REPOSTS #{theme_stats[:mean_reposts]}<br/>" +
      "VAR REPOSTS #{theme_stats[:var_reposts]}<br/>" +
      "MEAN VIEWS #{theme_stats[:mean_views]}<br/>" +
      "VAR VIEWS #{theme_stats[:var_views]}"
  end
end
