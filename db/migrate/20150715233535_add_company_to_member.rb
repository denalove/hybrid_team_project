class AddCompanyToMember < ActiveRecord::Migration
  def change
    add_reference :members, :company, index: true, foreign_key: true
  end
end
