class AddMainPostFlag < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :main, :boolean, default: false
  end
end
