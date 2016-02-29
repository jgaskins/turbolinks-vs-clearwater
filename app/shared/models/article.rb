class Article
  attr_reader :id, :title, :body, :created_at

  def initialize attributes={}
    @id = attributes[:id]
    @title = attributes[:title]
    @body = attributes[:body]
    @created_at = attributes[:created_at]

    @created_at = Time.parse(@created_at) if String === @created_at
  end
end
