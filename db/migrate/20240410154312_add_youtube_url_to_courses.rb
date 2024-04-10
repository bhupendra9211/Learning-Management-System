class AddYoutubeUrlToCourses < ActiveRecord::Migration[7.1]
  def change
    add_column :courses, :youtube_url, :string
  end
end
