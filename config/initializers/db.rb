require './app/shared/models/article'

print "Generating DB... "
start = Time.now
DB = {
  articles: Array.new(2_000) { |i|
    Article.new(
      id: SecureRandom.uuid,
      title: Faker::Lorem.sentence,
      body: Faker::Lorem.paragraphs(10),
      created_at: i.hours.ago,
    )
  }.each_with_object({}) { |model, hash| hash[model.id] = model },
}
finish = Time.now
puts "done in #{((finish - start) * 1000).to_i}ms."
