module ApplicationHelper
  def dashboard_initialize_all_class(group)
    if group.posts_job_running? and group.stats_job_running?
      "btn btn-success"
    else
      "btn btn-warning"
    end
  end

  def dashboard_posts_job_status_class(group)
    case true
    when group.posts_job_running?
      "btn btn-warning btn-sm disabled center-block"
    when group.posts_job_done?
      "btn btn-success btn-sm center-block"
    when true
      "btn btn-danger btn-sm center-block"
    end
  end

  def dashboard_stats_job_status_class(group)
    case true
    when group.stats_job_running?
      "btn btn-warning btn-sm disabled center-block"
    when group.stats_job_done?
      "btn btn-success btn-sm center-block"
    when true
      "btn btn-danger btn-sm center-block"
    end
  end
end
