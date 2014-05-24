class AddSlugToGlossaries < ActiveRecord::Migration
  def change
    add_column :glossaries, :slug, :string
  end
end
