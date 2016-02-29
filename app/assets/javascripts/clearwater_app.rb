require 'opal'
require 'clearwater'
require 'time'

require 'models/article'

class Layout
  include Clearwater::Component

  def render
    div([
      nav([
        ul([
          li(Link.new({ href: '/clearwater/articles' }, 'Articles')),
        ]),
      ]),
      outlet,
    ])
  end
end

ArticlesIndex = Struct.new(:articles) do
  include Clearwater::Component

  def render
    div([
      div({ style: index_style }, ArticlesList.new(articles)),
      div({ style: outlet_style }, outlet),
    ])
  end

  def index_style
    {
      display: 'inline-block',
      vertical_align: :top,
      width: '20%',
    }
  end

  def outlet_style
    {
      display: 'inline-block',
      vertical_align: :top,
      width: '80%',
    }
  end
end

ArticlesList = Struct.new(:articles) do
  include Clearwater::Component
  include Clearwater::CachedRender

  def should_render? previous
    !articles.equal?(previous.articles)
  end

  def render
    div([
      articles.map { |id, article|
        div({ key: id }, [
          Link.new({ href: "/clearwater/articles/#{id}" }, article.title),
        ])
      },
    ])
  end
end

ArticleDetail = Struct.new(:articles) do
  include Clearwater::Component

  def render
    article([
      h1(selected_article.title),
      selected_article.body.map { |paragraph|
        p(paragraph)
      },
    ])
  end

  def selected_article
    articles[params[:article_id]]
  end
end

articles = `gon.articles || []`.each_with_object({}) { |js_obj, hash|
  article = Article.new(Hash.new(js_obj))
  hash[article.id] = article
}

router = Clearwater::Router.new do
  # Ignore "/clearwater/" in the URL path
  namespace 'clearwater'

  route 'articles' => ArticlesIndex.new(articles) do
    route ':article_id' => ArticleDetail.new(articles)
  end
end

Clearwater::Application.new(
  component: Layout.new,
  router: router,
  element: Bowser.document['#clearwater-app'],
).call
