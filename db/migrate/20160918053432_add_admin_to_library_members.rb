class AddAdminToLibraryMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :library_members, :admin, :boolean
  end
end
