class AddUserToArticles < ActiveRecord::Migration[7.0]
  def change
    # First add the reference allowing null values
    add_reference :articles, :user, null: true, foreign_key: true

    # Create a default user if none exists
    reversible do |dir|
      dir.up do
        user = User.first_or_create!(
          email: 'default@example.com',
          password: 'password123',
          password_confirmation: 'password123'
        )
        
        # Assign all existing articles to this user
        Article.where(user_id: nil).update_all(user_id: user.id)
      end
    end

    # Now make it non-null
    change_column_null :articles, :user_id, false
  end
end
