class AddMemberReferenceToLoan < ActiveRecord::Migration[7.0]
  def change
    add_reference :loans, :member, foreign_key: true 
  end
end
