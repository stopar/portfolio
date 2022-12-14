class ChangeMemberIdInLoansToNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :loans, :member_id, false
  end
end
