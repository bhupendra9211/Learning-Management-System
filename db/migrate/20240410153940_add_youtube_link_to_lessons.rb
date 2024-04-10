class AddYoutubeLinkToLessons < ActiveRecord::Migration[7.1]
  def change
    add_column :lessons, :youtube_link, :string
  end
end
