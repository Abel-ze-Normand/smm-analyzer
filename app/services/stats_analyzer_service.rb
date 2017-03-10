class StatsAnalyzerService
  def initialize(options = {})
    @stats = options.fetch(:stats)
    @group_id = options.fetch(:group_id)
  end

  def call
    @stats.each { |s| analyze(s) }
  end

  private

  def analyze(stat)
    ::GroupPost.transaction do
      ::GroupPost.where(date: stat_day(stat), group_id: stat.group_id).each do |post|
        post.update_attributes!(group_stat_id: stat.id)
      end
    end
  end

  def stat_day(stat)
    stat.day.midnight..stat.day.end_of_day
  end
end
