class GetTargetAudienceService
  def initialize(options = {})
    @theme_id = options.fetch(:theme_id)
    @ranges = [12..18, 18..21, 21..24, 24..27, 27..30, 30..35, 35..45, 45..100]
  end

  def call
    average_target_audience_amount, =
      GroupStat
      .joins(:group_posts)
      .where("group_posts.theme_id = :theme_id", theme_id: @theme_id)
      .group(:day)
      .joins(:age_cluster)
      .pluck(build_age_clusters_query)

    names_with_avg_amount =
      @ranges.map { |r| "from #{r.first} to #{r.last}" }
             .zip(average_target_audience_amount)
             .reduce({}) { |acc, p| acc.merge(p.first => p.last) }

    # ["top_audience_name", "amount"]
    top_audience = names_with_avg_amount.each_pair
                                        .max { |p| p.last }

    { audience: names_with_avg_amount, top_audience: top_audience }
  end

  private

  def build_age_clusters_query
    @ranges.map { |r| "AVG(age_clusters.from_#{r.first}_to_#{r.last}_count)" }.join(", ")
  end
end
