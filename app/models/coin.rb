# == Schema Information
#
# Table name: coins
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  value      :integer          not null
#  created_at :datetime
#  updated_at :datetime
#  count      :integer          default(0)
#

class Coin < ApplicationRecord
    validates :name, :value, presence: true
   
    
    def total
         #grabbing count and value in subarrays
            coin_count = Coin.pluck(:count, :value) 
            sum = 0
            #going through each subarray (now an array) and multiplying count by value and adding to sum above
            coin_count.each{|arr| sum += arr[0] * arr[1]}
            #sum returned after iteration is completed!
            #returning sum in USD multiplied by 100 with zeros(.00) to give total to nearest decimal

           return sum/100.00
    end

   

    def minusCoin
        # subtract count by 1 
        self.count = self.count - 1
        self.save # save it
    end

    def refillCoin
        #refilling low quantity
         self.count = self.count + 1
         self.save #save it
    end
   



     
       
end


