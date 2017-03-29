class StaticPagesController < ApplicationController
  layout "login", only: [:index]
  def index
    render layout: "static"
  end
end
