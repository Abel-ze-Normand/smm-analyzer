class VkClient
  attr_reader :app

  def initialize
    service_app = VK::Application.new
    resp = service_app.server_auth(app_id: ENV['SMM_APP_ID'], app_secret: ENV['SMM_APP_SECRET'])
    @app = VK::Application.new do |app|
      app.app_id = ENV['SMM_APP_ID']
      app.app_secret = ENV['SMM_APP_SECRET']
      app.access_token = resp['access_token']
    end
  end

  def find_user(s)
    @app.users.get(user_ids: s)
  end

  def find_groups(uid)
    @app.groups.get(user_id: uid)
  end

  def get_stats(gid)
    @app.stats.get(group_id: gid)
  end

  def get_posts(gid)
    probe = @app.wall.get(owner_id: "-#{gid}", filter: "owner")
    step = 100
    pages = probe['count'] / step
    (0...pages).reduce([]) do |acc, i|
      resp = @app.wall.get(owner_id: "-#{gid}", filter: "owner", offset: step * i, count: step)
      acc + resp['items']
    end
  end
end
