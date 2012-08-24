class RenameColumnTagToNameInTags < ActiveRecord::Migration
  def up
    rename_column :tags, :tag, :name
  end

  def down
    rename_column :tags, :name, :tag
  end
end
