module ThemesHelper
  def print_theme_stats(theme_stats)
    "MEAN LIKES: #{theme_stats[:mean_likes]}<br/>" +
      "VAR LIKES: #{theme_stats[:var_likes]}<br/>" +
      "MEAN REPOSTS #{theme_stats[:mean_reposts]}<br/>" +
      "VAR REPOSTS #{theme_stats[:var_reposts]}<br/>" +
      "MEAN VIEWS #{theme_stats[:mean_views]}<br/>" +
      "VAR VIEWS #{theme_stats[:var_views]}"
  end

  def popular_themes_chart(themes)
    column_chart(
      themes.reduce({}) { |acc, t| acc.merge(t["name"] => Theme.new(t).stats_accumulated) }, height: '500px', library: {
        title: { text: 'Most popular themes' },
        yAxis: {
          title: { text: 'Specific weight' },
        },
        xAxis: {
          title: { text: 'Name' }
        }
      }
    )
  end

  def render_audience_chart(target_audience_data)
    pie_chart(target_audience_data["audience"])
  end
end
