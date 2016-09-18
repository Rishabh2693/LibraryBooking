class AddPasswordDigestToLibraryMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :library_members, :password_digest, :string
  end
end
