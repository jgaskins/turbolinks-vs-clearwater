module Turbolinks
  class ArticlesController < ApplicationController

    def index
    end

    def show
      @article = DB[:articles].fetch(params[:id]) do
        redirect_to turbolinks_articles_path,
          alert: 'No article with that id'
      end
    end

    def articles
      @articles = DB[:articles].each_value
    end
    helper_method :articles
  end
end
