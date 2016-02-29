class HomeController < ApplicationController
  def index
  end

  def clearwater
    gon.push articles: DB[:articles].values
  end
end
