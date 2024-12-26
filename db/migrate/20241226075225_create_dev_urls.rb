class CreateDevUrls < ActiveRecord::Migration[7.1]
  def change
    create_table :dev_urls do |t|
      t.string :original_url
      t.string :short_url

      t.timestamps
    end
  end
end
