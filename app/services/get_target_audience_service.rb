class GetTargetAudienceService
  RANGES = [12..18, 18..21, 21..24, 24..27, 27..30, 30..35, 35..45, 45..100]
  def initialize(options = {})
    @theme_id = options.fetch(:theme_id)
  end

  def call
    cached_val = CacheService.get("target-audience-#{@theme_id}")
    return cached_val if cached_val

    average_target_audience_amount, =
      GroupStat
      .joins(:group_posts)
      .where("group_posts.theme_id = :theme_id", theme_id: @theme_id)
      .group(:day)
      .joins(:age_cluster)
      .pluck(build_age_clusters_query)

    raise Exception.new("error in aggregation") unless average_target_audience_amount

    names_with_avg_amount =
      RANGES.map { |r| "from #{r.first} to #{r.last}" }
            .zip(average_target_audience_amount)
            .reduce({}) { |acc, p| acc.merge(p.first => p.last) }

    # ["top_audience_name", "amount"]
    top_audience = names_with_avg_amount.each_pair
                                        .max { |a, b| a.last <=> b.last }

    res = { audience: names_with_avg_amount, top_audience: top_audience }

    CacheService.set("target-audience-#{@theme_id}", res)

    res
  end

  private

  def build_age_clusters_query
    RANGES.map { |r| "AVG(age_clusters.from_#{r.first}_to_#{r.last}_count)" }.join(", ")
  end
end
