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

require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
