# Create a test user
user = User.find_or_create_by!(email: 'test@example.com') do |u|
  u.password = 'password123'
  u.password_confirmation = 'password123'
end

# Create some sample articles
articles_data = [
  {
    body: 'This is the first article. It contains some interesting content about Ruby on Rails development.',
    reports_count: 0,
    status: 'published'
  },
  {
    body: 'Second article discussing web development best practices and techniques.',
    reports_count: 0,
    status: 'published'
  },
  {
    body: 'Third article about database optimization and performance tuning in Rails applications.',
    reports_count: 0,
    status: 'published'
  }
]

articles_data.each do |article_data|
  user.articles.find_or_create_by!(body: article_data[:body]) do |article|
    article.reports_count = article_data[:reports_count]
    article.status = article_data[:status]
  end
end

puts "Seed data created successfully!"
