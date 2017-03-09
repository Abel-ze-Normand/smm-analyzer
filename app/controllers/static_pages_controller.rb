class StaticPagesController < ApplicationController
  layout "login", only: [:index]
  def index
  end
end
