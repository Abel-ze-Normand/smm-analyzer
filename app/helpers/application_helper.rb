module ApplicationHelper
  def dashboard_posts_job_status_class(group)
    case true
    when group.posts_job_running?
      "btn btn-warning btn-sm disabled"
    when group.posts_job_done?
      "btn btn-success btn-sm"
    when true
      "btn btn-danger btn-sm"
    end
  end

  def dashboard_stats_job_status_class(group)
    case true
    when group.stats_job_running?
      "btn btn-warning btn-sm disabled"
    when group.stats_job_done?
      "btn btn-success btn-sm"
    when true
      "btn btn-danger btn-sm"
    end
  end
end
