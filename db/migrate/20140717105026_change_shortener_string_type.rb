class ChangeShortenerStringType < ActiveRecord::Migration
  def change
    change_column :shortened_urls, :url, :text
  end
end
