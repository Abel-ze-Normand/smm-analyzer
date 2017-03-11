module Vk
  class ParseStatsService
    def initialize(options = {})
      @stats = options.fetch(:stats)
      @group_id = options.fetch(:group_id)
    end

    def call
      ::GroupStat.transaction do
        ::AgeCluster.transaction do
          @stats.map do |stat|
            s = cons_group_stat(stat)
            s.group = Group.find(@group_id)
            s.save!
            a_c = cons_age_cluster(stat)
            a_c.group_stat = s
            a_c.save!
          end
        end
      end
    end

    private

    def cons_group_stat(stat)
      GroupStat.new(
        day: DateTime.parse(stat["day"]),
        unique_visitors_count: stat["visitors"],
        subscribed_count: stat["subscribed"],
        unsubscribed_count: stat["unsubscribed"],
      )
    end

    def cons_age_cluster(stat)
      # protocol
      # "age": [{
      # "visitors": 326,
      # "value": "12-18"
      # }, {
      # "visitors": 179,
      # "value": "18-21"
      # }
      age_list = stat["age"]
      age_list.reduce(AgeCluster.new) do |a_c, age_dict|
        from_v, to_v = age_dict["value"].split('-')
        views = age_dict["visitors"]
        a_c.send("from_#{from_v}_to_#{to_v}_count=".to_s, views)
        a_c
      end
    end
  end
end
