# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  api_key         :string           not null
#  created_at      :datetime
#  updated_at      :datetime
#  email           :string
#  password_digest :string
#  account_type    :string
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
