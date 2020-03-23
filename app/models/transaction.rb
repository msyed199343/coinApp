# == Schema Information
#
# Table name: transactions
#
#  id               :bigint           not null, primary key
#  coin_id          :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#  user_id          :integer          not null
#  transaction_type :string           not null
#

class Transaction < ApplicationRecord
        validates :coin_id, :user_id, :transaction_type, null: false
        # validates :coin_id, :user_id, uniqueness: true
        belongs_to :user

        
end
