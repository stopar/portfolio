class ChangeIcNumberTypeInMembers < ActiveRecord::Migration[7.0]
  def change
    change_column :members, :ic_number, :string
  end
end
